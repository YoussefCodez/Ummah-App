import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/features/prayers/presentation/cubit/get_prayers_cubit.dart';
import 'package:ummah/features/prayers/presentation/screens/widgets/month_header.dart';
import 'package:ummah/features/prayers/presentation/screens/widgets/prayer_day_item.dart';


// ignore: must_be_immutable
class PrayersScreen extends StatelessWidget {
  PrayersScreen({super.key});
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => getIt<GetPrayersCubit>()..getMonthTimings(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<GetPrayersCubit, GetPrayersState>(
          builder: (context, state) {
            if(state is GetPrayersLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(state is GetPrayersError){
              return Center(child: Text(state.error));
            }else if(state is GetPrayersSuccess){
              final String todayDate = DateFormat('dd MMM yyyy', 'en').format(DateTime.now()); 
              return Column(
              children: [
                MonthHeader(
                  monthName: state.prayers.first.gregorianMonth,
                  year: state.prayers.first.gregorianYear,
                  hijriMonth: state.prayers.first.hijriMonth,
                  hijriYear: state.prayers.first.hijriYear,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: REdgeInsets.only(top: 10, bottom: 20),
                    itemCount: state.prayers.length,
                    itemBuilder: (context, index) {
                      final dayData = state.prayers[index];
                      return PrayerDayItem(
                        day: dayData.gregorianDate.substring(0 , 2),
                        dayName: context.locale.toString() == 'ar' ? dayData.weekDayAr : dayData.weekDayEn,
                        isToday: dayData.gregorianDate == todayDate,
                        timings: [
                          ("assets/svgs/fajr.svg", "الفجر", dayData.convertTo12HourWithPeriod(dayData.fajr)),
                          ("assets/svgs/sunrise.svg", "الشروق", dayData.convertTo12HourWithPeriod(dayData.sunrise)),
                          ("assets/svgs/sun.svg", "الظهر", dayData.convertTo12HourWithPeriod(dayData.dhuhr)),
                          ("assets/svgs/asr.svg", "العصر", dayData.convertTo12HourWithPeriod(dayData.asr)),
                          ("assets/svgs/maghreeb.svg", "المغرب", dayData.convertTo12HourWithPeriod(dayData.maghrib)),
                          ("assets/svgs/isah.svg", "العشاء", dayData.convertTo12HourWithPeriod(dayData.isha)),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white,size: 24.r,),
        ),
      ),
    );
  }
}
