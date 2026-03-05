import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/services/device_utils_service.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/home/presentation/cubit/get_timing_by_city_cubit.dart';
import 'package:ummah/core/constants/app_strings.dart';

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
            padding: REdgeInsets.all(
              DeviceUtilsService.isTablet(context) ? 22.r : 18,
            ),
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
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: REdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 21,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentSalah.name,
                              style: TextStyle(
                                color: AppColors.secondryColorText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              state.timingEntity.convertTo12HourWithPeriod(
                                currentSalah.timeStr,
                              ),
                              style: TextStyle(
                                color: AppColors.secondryColorText,
                                fontSize: DeviceUtilsService.isTablet(context)
                                    ? 25.sp
                                    : 30.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(20.h),
                            Text(
                              "${AppStrings.nextPrayLabel} : ${nextSalah.name}",
                              style: TextStyle(
                                color: AppColors.secondryColorText,
                                fontSize: DeviceUtilsService.isTablet(context)
                                    ? 16.sp
                                    : 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              state.timingEntity.convertTo12HourWithPeriod(
                                nextSalah.timeStr,
                              ),
                              style: TextStyle(
                                color: AppColors.secondryColorText,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          "assets/images/quran.png",
                          height: 150.h,
                          width: 150.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        if (state is GetTimingByCityFailure) {
          return Padding(
            padding: REdgeInsets.all(18),
            child: Container(
              width: double.infinity,
              padding: REdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(17.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.wifi_off_rounded,
                    color: Theme.of(context).colorScheme.error,
                    size: 32.r,
                  ),
                  Gap(12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.noInternetTitle,
                          style: TextStyle(
                            fontFamily: 'Main',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        Gap(4.h),
                        Text(
                          AppStrings.noInternetBody,
                          style: TextStyle(
                            fontFamily: 'Main',
                            fontSize: 12.sp,
                            color: Theme.of(
                              context,
                            ).colorScheme.onErrorContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
