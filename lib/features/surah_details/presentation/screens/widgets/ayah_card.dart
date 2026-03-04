import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_with_tafsir/quran_with_tafsir.dart';
import 'package:ummah/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_state.dart';
import 'package:ummah/features/surah_details/presentation/cubit/quran_tafsir_cubit.dart';
import 'package:ummah/core/constants/app_strings.dart';

class AyahCard extends StatelessWidget {
  final Ayah ayah;

  const AyahCard({super.key, required this.ayah});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildActionRow(context),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
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
                          color: Theme.of(context).colorScheme.onSurface,
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
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Row(
        children: [
          _buildAyahNumber(context),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.play_circle_outline,
              size: 24.r,
              color: Theme.of(context).colorScheme.primary,
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

  Widget _buildAyahNumber(BuildContext context) {
    return Container(
      width: 32.r,
      height: 32.r,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          ayah.id.toString(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              final tafsirText = state.tafsir[ayah.id] ?? "";
              final cleanedTafsir = tafsirText.length > 4
                  ? tafsirText.substring(4)
                  : tafsirText;
              return Text(
                "${AppStrings.tafsir}: $cleanedTafsir",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                      AppStrings.sajda,
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
              "${AppStrings.juzEn} ${ayah.juz}",
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.4),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
