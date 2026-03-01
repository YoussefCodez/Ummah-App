import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_with_tafsir/quran_with_tafsir.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_state.dart';
import 'package:ummah/features/surah_details/presentation/cubit/quran_tafsir_cubit.dart';
import 'package:ummah/features/surah_details/presentation/screens/widgets/play_button.dart';

class AyahBottomSheet extends StatelessWidget {
  final Ayah ayah;

  const AyahBottomSheet({super.key, required this.ayah});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),

          // Header with Play Action
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                "آية  ${ayah.id}",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: .bold,
                  fontFamily: 'QuranFont',
                  color: AppColors.primaryColor,
                ),
              ),
              PlayButton(ayah: ayah),
            ],
          ),

          Gap(20.h),

          // Scrolling Content
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Flexible(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      // Ayah Text
                      Container(
                        padding: EdgeInsets.all(15.r),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Text(
                          ayah.text,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'QuranFont',
                            fontSize: state is SettingsLoaded
                                ? state.settings.textFontSize.sp
                                : 22.sp,
                            height: 1.8,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Gap(20.h),
                      // Tafsir Section
                      Text(
                        "التفسير",
                        textDirection: .rtl,
                        style: TextStyle(
                          fontSize: state is SettingsLoaded
                              ? state.settings.textFontSize.sp - 6.sp
                              : 16.sp,
                          fontWeight: .bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Gap(10.h),
                      BlocBuilder<QuranTafsirCubit, QuranTafsirState>(
                        builder: (context, state) {
                          if (state is QuranTafsirLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is QuranTafsirFailure) {
                            return Text(
                              "عذراً، فشل تحميل التفسير",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                              ),
                            );
                          }
                          if (state is QuranTafsirSuccess) {
                            final tafsirText =
                                state.tafsir[ayah.id] ?? "التفسير غير متوفر";
                            final cleanedTafsir = tafsirText.substring(4);
                            return Text(
                              cleanedTafsir,
                              textDirection: .rtl,
                              style: TextStyle(
                                fontSize: 18.sp,
                                height: 1.6,
                                color: Colors.black54,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      Gap(20.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
