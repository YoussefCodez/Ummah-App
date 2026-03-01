import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_cubit.dart';
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
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Main',
            fontWeight: .bold,
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
                SettingsSectionHeader(title: 'Text Options'),
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
                              'Font Size',
                              style: TextStyle(
                                fontFamily: 'Main',
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              '${settings.textFontSize.toInt()}',
                              style: TextStyle(
                                fontFamily: 'Main',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
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
                        divisions: 16,
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
                      'Bold Text',
                      style: TextStyle(fontFamily: 'Main', fontSize: 16.sp),
                    ),
                    value: settings.isTextBold,
                    activeThumbColor: theme.colorScheme.primary,
                    thumbColor: WidgetStateProperty.all(Colors.white),
                    onChanged: (value) {
                      context.read<SettingsCubit>().changeTextBold(value);
                    },
                  ),
                ),
                Gap(30.h),
                SettingsSectionHeader(title: 'Mushaf Display Mode'),
                Gap(10.h),
                SettingsCard(
                  child: RadioGroup<String>(
                    groupValue: settings.mushafMode,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<SettingsCubit>().changeMushafMode(
                          value == 'mushaf',
                        );
                      }
                    },
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: Text(
                            'Pages (Mushaf)',
                            style: TextStyle(
                              fontFamily: 'Main',
                              fontSize: 16.sp,
                            ),
                          ),
                          value: 'mushaf',
                          activeColor: theme.colorScheme.primary,
                        ),
                        RadioListTile<String>(
                          title: Text(
                            'Ayahs',
                            style: TextStyle(
                              fontFamily: 'Main',
                              fontSize: 16.sp,
                            ),
                          ),
                          value: 'ayah',
                          activeColor: theme.colorScheme.primary,
                        ),
                      ],
                    ),
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
