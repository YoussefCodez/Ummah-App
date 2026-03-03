import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/services/device_utils_service.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:ummah/features/surah_details/presentation/cubit/quran_tafsir_cubit.dart';
import 'package:ummah/features/surah_details/presentation/cubit/select_ayah_cubit.dart';
import 'package:ummah/features/surah_details/presentation/screens/widgets/mushaf_page.dart';

class MushafScreen extends StatelessWidget {
  // استقبال رقم الصفحة التي سيبدأ منها المصحف (افتراضياً صفحة 1)
  const MushafScreen({super.key, this.initialPage = 1});
  final int initialPage;

  @override
  Widget build(BuildContext context) {
    // استخدام MultiBlocProvider لتوفير الـ Cubits اللازمة للشاشة
    return MultiBlocProvider(
      providers: [
        // توفير Cubit القرآن وتحميل بيانات السور
        BlocProvider(create: (context) => getIt<QuranCubit>()..loadSurahs()),
        // توفير Cubit اختيار الآيات (لتظليل الآية المختارة)
        BlocProvider(create: (context) => SelectAyahCubit()),
        // توفير Cubit التفسير
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
  // المتحكم في تقليب الصفحات
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // تهيئة المتحكم ببدء التشغيل من الصفحة المطلوبة (Index يبدأ من 0)
    _pageController = PageController(initialPage: widget.initialPage - 1);

    // الوصول للـ Cubits لربط الأحداث الصوتية بالواجهة
    final quranCubit = context.read<QuranCubit>();
    final selectCubit = context.read<SelectAyahCubit>();

    // تعريف ماذا يحدث عندما تتغير الآية صوتياً
    quranCubit.onAyahChanged = (int surah, int ayah, int page) {
      if (!mounted) return;

      // 1. تحديث تظليل الآية الحالية في الواجهة
      selectCubit.selectAyah(surah, ayah);

      // 2. التحقق من رقم الصفحة؛ إذا انتقل الصوت لصفحة جديدة، يتم تقليب المصحف آلياً
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
      // عند الضغط في أي مكان فارغ، يتم إلغاء تظليل الآية
      onTap: () {
        context.read<SelectAyahCubit>().clearAyah();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          actionsPadding: REdgeInsets.only(right: DeviceUtilsService.isTablet(context) ? 10 : 0) ,
          toolbarHeight: DeviceUtilsService.isTablet(context) ? 80.h : 60.h,
          leading: Padding(
            padding: REdgeInsets.only(left: DeviceUtilsService.isTablet(context) ? 10 : 0),
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
            "القرآن الكريم",
            style: TextStyle(
              fontFamily: 'QuranFont',
              color: AppColors.primaryColor,
              fontSize: 21.sp,
            ),
          ),
          centerTitle: true,
          actions: [
            // زر التشغيل/الإيقاف مع مراقبة الحالة لحظياً
            BlocBuilder<QuranCubit, QuranState>(
              builder: (context, state) {
                final quran = context.read<QuranCubit>();
                bool isPlaying = false;
                // تحديد شكل الأيقونة بناءً على حالة الـ Cubit
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
                      // إيقاف الصوت إذا كان يعمل
                      quran.stopPlaying();
                    } else {
                      final selectCubit = context.read<SelectAyahCubit>();
                      final quranCubit = context.read<QuranCubit>();
                      // البدء من آية محددة إذا كان اليوزر قد اختار واحدة
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
                        // إذا لم يتم اختيار آية، نبدأ من بداية الصفحة الحالية
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
        // عرض صفحات المصحف باستخدام PageView لتمكين التقليب الأفقي
        body: PageView.builder(
          controller: _pageController,
          reverse: true, // التقليب من اليمين لليسار (عربي)
          itemCount: 604, // عدد صفحات المصحف
          itemBuilder: (context, index) {
            final pageNumber = index + 1;
            return MushafPage(pageNumber: pageNumber);
          },
        ),
      ),
    );
  }
}
