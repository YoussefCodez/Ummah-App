import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_hijri_calendar/islamic_hijri_calendar.dart';
import 'package:ummah/features/calendar/cubit/dates_cubit.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EnglishDatesCubit()),
        BlocProvider(create: (context) => HijriDatesCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness:
                Theme.of(context).brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
            statusBarBrightness: Theme.of(context).brightness,
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<HijriDatesCubit, String>(
            builder: (context, hijriDate) {
              return BlocBuilder<EnglishDatesCubit, String>(
                builder: (context, englishDate) {
                  return Column(
                    children: [
                      IslamicHijriCalendar(
                        isHijriView: true,
                        highlightBorder: Theme.of(context).colorScheme.primary,
                        defaultBorder: Theme.of(
                          context,
                        ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                        highlightTextColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                        defaultTextColor: Theme.of(
                          context,
                        ).colorScheme.onSurface,
                        defaultBackColor: Theme.of(context).colorScheme.surface,
                        adjustmentValue: 0,
                        isGoogleFont: true,
                        fontFamilyName: "Lato",
                        getSelectedEnglishDate: (selectedDate) {
                          context.read<EnglishDatesCubit>().getEnglishDate(
                            selectedDate.toString(),
                          );
                        },
                        getSelectedHijriDate: (selectedDate) {
                          context.read<HijriDatesCubit>().getHijriDate(
                            selectedDate.toString(),
                          );
                        },
                        isDisablePreviousNextMonthDates: true,
                      ),
                      Column(
                        children: [
                          Gap(20.h),
                          Text(
                            englishDate.split(" ")[0],
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Gap(20.h),
                          Text(
                            hijriDate,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
