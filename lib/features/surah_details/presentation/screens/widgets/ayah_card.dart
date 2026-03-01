import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_with_tafsir/quran_with_tafsir.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_state.dart';
import 'package:ummah/features/surah_details/presentation/cubit/quran_tafsir_cubit.dart';

class AyahCard extends StatelessWidget {
  final Ayah ayah;

  const AyahCard({super.key, required this.ayah});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          _buildActionRow(context),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
            child: Column(
              crossAxisAlignment: .end,
              children: [
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    if (state is SettingsLoaded) {
                      return Text(
                        ayah.text,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'QuranFont',
                          fontSize: state.settings.textFontSize.sp,
                          height: 2.2,
                          color: AppColors.onThirdColor,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Gap(15.h),
                _buildMetadataRow(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Row(
        children: [
          _buildAyahNumber(),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.play_circle_outline,
              size: 24.r,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              final url = context.read<QuranCubit>().getAudioUrl(
                ayah.surahNumber,
                ayah.id,
              );
              context.read<QuranCubit>().loadAudio(url);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAyahNumber() {
    return Container(
      width: 32.r,
      height: 32.r,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          ayah.id.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataRow(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        BlocBuilder<QuranTafsirCubit, QuranTafsirState>(
          builder: (context, state) {
            if (state is QuranTafsirLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is QuranTafsirFailure) {
              return Center(child: Text(state.message));
            }
            if (state is QuranTafsirSuccess) {
              return Text(
                "التفسير : ${state.tafsir[ayah.id]!.substring(4)}",
                textDirection: .rtl,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black54,
                  fontWeight: .w500,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        Row(
          mainAxisAlignment: .start,
          children: [
            if (ayah.isSajda) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, size: 14.r, color: Colors.orange),
                    Gap(4.w),
                    Text(
                      'Sajda',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(10.w),
            ],
            Text(
              'Juz ${ayah.juz}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
