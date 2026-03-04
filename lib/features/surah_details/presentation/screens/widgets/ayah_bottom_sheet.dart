import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_with_tafsir/quran_with_tafsir.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_state.dart';
import 'package:ummah/features/surah_details/presentation/cubit/quran_tafsir_cubit.dart';
import 'package:ummah/features/surah_details/presentation/screens/widgets/play_button.dart';
import 'package:ummah/core/constants/app_strings.dart';

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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),

          // Header with Play Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppStrings.ayah}  ${ayah.id}",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'QuranFont',
                  color: Theme.of(context).colorScheme.primary,
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Ayah Text
                      Container(
                        padding: EdgeInsets.all(15.r),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Text(
                          ayah.text,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'QuranFont',
                            fontSize: 22.sp,
                            height: 1.8,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      Gap(20.h),
                      // Tafsir Section
                      Text(
                        AppStrings.tafsir,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
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
                              AppStrings.tafsirError,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 14.sp,
                              ),
                            );
                          }
                          if (state is QuranTafsirSuccess) {
                            final tafsirText =
                                state.tafsir[ayah.id] ??
                                AppStrings.tafsirNotAvailable;
                            final cleanedTafsir = tafsirText.length > 4
                                ? tafsirText.substring(4)
                                : tafsirText;
                            return Text(
                              cleanedTafsir,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 18.sp,
                                height: 1.6,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.7),
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
