import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/home/presentation/cubit/get_timing_by_city_cubit.dart';

class PrayersWidget extends StatelessWidget {
  const PrayersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTimingByCityCubit, GetTimingByCityState>(
      builder: (context, state) {
        if (state is GetTimingByCitySuccess) {
          final currentSalah = state.salwat[state.activeAndNextIndex.$1];
          final nextSalah = state.salwat[state.activeAndNextIndex.$2];
          return Padding(
            padding: REdgeInsets.all(18),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.onSecondryColor,
                        AppColors.onSecondryContainer,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(17.r),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: REdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 21,
                        ),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              currentSalah.name,
                              style: TextStyle(
                                color: AppColors.secondryColorText,
                                fontSize: 14.sp,
                                fontWeight: .w500,
                              ),
                            ),
                            Text(
                              state.timingEntity.convertTo12HourWithPeriod(
                                currentSalah.timeStr,
                              ),
                              style: TextStyle(
                                color: AppColors.secondryColorText,
                                fontSize: 30.sp,
                                fontWeight: .bold,
                              ),
                            ),
                            Gap(20.h),
                            Text(
                              "Next Pray : ${nextSalah.name}",
                              style: TextStyle(
                                color: AppColors.secondryColorText,
                                fontSize: 18.sp,
                                fontWeight: .w500,
                              ),
                            ),
                            Text(
                              state.timingEntity.convertTo12HourWithPeriod(
                                nextSalah.timeStr,
                              ),
                              style: TextStyle(
                                color: AppColors.secondryColorText,
                                fontSize: 20.sp,
                                fontWeight: .bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          "assets/images/quran.png",
                          height: 170.h,
                          width: 170.w,
                          fit: .cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
