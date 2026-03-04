import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/services/device_utils_service.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:ummah/features/surah_details/presentation/cubit/quran_tafsir_cubit.dart';
import 'package:ummah/features/surah_details/presentation/cubit/select_ayah_cubit.dart';
import 'package:ummah/features/surah_details/presentation/screens/widgets/mushaf_page.dart';
import 'package:ummah/core/constants/app_strings.dart';

class MushafScreen extends StatelessWidget {
  const MushafScreen({super.key, this.initialPage = 1});
  final int initialPage;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<QuranCubit>()..loadSurahs()),
        BlocProvider(create: (context) => SelectAyahCubit()),
        BlocProvider(create: (context) => getIt<QuranTafsirCubit>()),
      ],
      child: MushafView(initialPage: initialPage),
    );
  }
}

class MushafView extends StatefulWidget {
  const MushafView({super.key, required this.initialPage});
  final int initialPage;

  @override
  State<MushafView> createState() => _MushafViewState();
}

class _MushafViewState extends State<MushafView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage - 1);

    final quranCubit = context.read<QuranCubit>();
    final selectCubit = context.read<SelectAyahCubit>();

    quranCubit.onAyahChanged = (int surah, int ayah, int page) {
      if (!mounted) return;
      selectCubit.selectAyah(surah, ayah);
      final currentPage = _pageController.page?.round() ?? 0;
      if (currentPage != page - 1) {
        _pageController.animateToPage(
          page - 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SelectAyahCubit>().clearAyah();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness:
                Theme.of(context).brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
            statusBarBrightness: Theme.of(context).brightness,
          ),
          actionsPadding: REdgeInsets.only(
            right: DeviceUtilsService.isTablet(context) ? 10 : 0,
          ),
          toolbarHeight: DeviceUtilsService.isTablet(context) ? 80.h : 60.h,
          leading: Padding(
            padding: REdgeInsets.only(
              left: DeviceUtilsService.isTablet(context) ? 10 : 0,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryColor,
                size: 20.r,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: Text(
            AppStrings.quranKareem,
            style: TextStyle(
              fontFamily: 'QuranFont',
              color: AppColors.primaryColor,
              fontSize: 21.sp,
            ),
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<QuranCubit, QuranState>(
              builder: (context, state) {
                final quran = context.read<QuranCubit>();
                bool isPlaying = false;
                if (state is QuranPageSuccess) {
                  isPlaying = state.isPlaying;
                } else {
                  isPlaying = quran.isPlaying;
                }
                return IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColors.primaryColor,
                    size: 20.r,
                  ),
                  onPressed: () {
                    if (isPlaying) {
                      quran.stopPlaying();
                    } else {
                      final selectCubit = context.read<SelectAyahCubit>();
                      final quranCubit = context.read<QuranCubit>();
                      if (selectCubit.state.isNotEmpty) {
                        if (quranCubit.state is QuranPageSuccess) {
                          final pState = quranCubit.state as QuranPageSuccess;
                          final selectedAyah = pState.ayahs.firstWhere(
                            (a) =>
                                "${a.surahNumber}_${a.id}" == selectCubit.state,
                            orElse: () => pState.ayahs.first,
                          );
                          quranCubit.startPlaying(
                            surah: selectedAyah.surahNumber,
                            ayah: selectedAyah.id,
                          );
                        }
                      } else {
                        if (quranCubit.state is QuranPageSuccess) {
                          final pState = quranCubit.state as QuranPageSuccess;
                          if (pState.ayahs.isNotEmpty) {
                            quranCubit.startPlaying(
                              surah: pState.ayahs.first.surahNumber,
                              ayah: pState.ayahs.first.id,
                            );
                          }
                        }
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          reverse: true,
          itemCount: 604,
          itemBuilder: (context, index) {
            final pageNumber = index + 1;
            return MushafPage(pageNumber: pageNumber);
          },
        ),
      ),
    );
  }
}
