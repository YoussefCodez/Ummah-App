import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_with_tafsir/models/reciters.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_state.dart';
import 'package:ummah/features/settings/presentation/screens/widgets/settings_card.dart';
import 'package:ummah/features/settings/presentation/screens/widgets/settings_section_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        title: Text(
          AppStrings.settings,
          style: TextStyle(
            fontFamily: 'Main',
            fontWeight: .bold,
            fontSize: 16.sp,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            final settings = state.settings;
            return ListView(
              padding: EdgeInsets.all(20.r),
              children: [
                SettingsSectionHeader(title: AppStrings.textOptions),
                Gap(10.h),
                SettingsCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.fontSize,
                              style: TextStyle(
                                fontFamily: 'Main',
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              '${settings.textFontSize.toInt()}',
                              style: TextStyle(
                                fontFamily: 'Main',
                                fontSize: 14.sp,
                                fontWeight: .bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Slider(
                        value: settings.textFontSize,
                        min: 16.0,
                        max: 48.0,
                        divisions: 10,
                        activeColor: theme.colorScheme.primary,
                        inactiveColor: theme.colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                        onChanged: (value) {
                          context.read<SettingsCubit>().changeTextFontSize(
                            value,
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'QuranFont',
                            fontSize: settings.textFontSize,
                            fontWeight: settings.isTextBold
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      Gap(10.h),
                    ],
                  ),
                ),
                Gap(20.h),
                SettingsCard(
                  child: SwitchListTile(
                    title: Text(
                      AppStrings.boldText,
                      style: TextStyle(fontFamily: 'Main', fontSize: 14.sp),
                    ),
                    value: settings.isTextBold,
                    activeThumbColor: theme.colorScheme.primary,
                    onChanged: (value) {
                      context.read<SettingsCubit>().changeTextBold(value);
                    },
                  ),
                ),
                Gap(20.h),
                SettingsSectionHeader(title: AppStrings.displayMode),
                Gap(10.h),
                SettingsCard(
                  child: SwitchListTile(
                    title: Text(
                      AppStrings.darkMode,
                      style: TextStyle(fontFamily: 'Main', fontSize: 14.sp),
                    ),
                    value: settings.isDarkMode,
                    activeThumbColor: theme.colorScheme.primary,
                    onChanged: (value) {
                      context.read<SettingsCubit>().changeDarkMode(value);
                    },
                  ),
                ),
                Gap(30.h),
                SettingsSectionHeader(title: AppStrings.mushafDisplayMode),
                Gap(10.h),
                SettingsCard(
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: Text(
                          AppStrings.pagesMushaf,
                          style: TextStyle(fontFamily: 'Main', fontSize: 14.sp),
                        ),
                        value: 'mushaf',
                        groupValue: settings.mushafMode,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<SettingsCubit>().changeMushafMode(
                              true,
                            );
                          }
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(
                          AppStrings.ayahs,
                          style: TextStyle(fontFamily: 'Main', fontSize: 14.sp),
                        ),
                        value: 'ayah',
                        groupValue: settings.mushafMode,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<SettingsCubit>().changeMushafMode(
                              false,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Gap(20.h),
                SettingsSectionHeader(title: AppStrings.readers),
                Gap(10.h),
                SettingsCard(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: Reciters.displayNames.length,
                    itemBuilder: (context, index) {
                      final entry = Reciters.displayNames.entries
                          .toList()[index];
                      final reciterId = entry.key;
                      final reciterName = entry.value;

                      return RadioListTile<String>(
                        title: Text(
                          reciterName,
                          style: TextStyle(fontFamily: 'Main', fontSize: 14.sp),
                        ),
                        value: reciterId,
                        groupValue: settings.reciter,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<SettingsCubit>().changeReciter(value);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
