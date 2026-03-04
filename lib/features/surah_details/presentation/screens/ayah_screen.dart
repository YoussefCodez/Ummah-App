import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_with_tafsir/models/meta.dart';
import 'package:quran_with_tafsir/quran_with_tafsir.dart';
import 'package:ummah/core/services/device_utils_service.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:ummah/features/surah_details/presentation/cubit/quran_tafsir_cubit.dart';
import 'package:ummah/features/surah_details/presentation/screens/widgets/ayah_card.dart';

class AyahScreen extends StatefulWidget {
  const AyahScreen({super.key, required this.surah});
  final SurahMetadata surah;
  @override
  State<AyahScreen> createState() => _AyahScreenState();
}

class _AyahScreenState extends State<AyahScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<QuranCubit>()..loadSpecificSurah(widget.surah.number),
        ),
        BlocProvider(
          create: (context) =>
              getIt<QuranTafsirCubit>()..loadTafsir(widget.surah.number),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          scrolledUnderElevation: 0,
          toolbarHeight: DeviceUtilsService.isTablet(context) ? 80.h : 60.h,
          actionsPadding: REdgeInsets.only(
            right: DeviceUtilsService.isTablet(context) ? 10 : 0,
          ),
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
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            widget.surah.nameAr,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: AppColors.primaryColor,
              fontSize: 21.sp,
              fontFamily: 'QuranFont',
            ),
          ),
          centerTitle: true,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness:
                Theme.of(context).brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
            statusBarBrightness: Theme.of(context).brightness,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<QuranCubit, QuranState>(
                builder: (context, state) {
                  if (state is QuranSurahLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is QuranSurahFailure) {
                    return Center(child: Text(state.message));
                  }
                  if (state is QuranSurahSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: state.surah.verses.length,
                      itemBuilder: (context, index) {
                        final ayah = state.surah.verses[index];
                        return AyahCard(ayah: ayah);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Gap(120.h),
            ],
          ),
        ),
      ),
    );
  }
}
