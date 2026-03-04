import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ummah/core/config/location_cubit.dart';
import 'package:ummah/core/services/device_utils_service.dart';
import 'package:ummah/features/home/presentation/cubit/get_timing_by_city_cubit.dart';
import 'package:ummah/core/constants/app_strings.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.place,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: DeviceUtilsService.isTablet(context)
                      ? 12.sp
                      : 15.sp,
                ),
              ),
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  if (state is LocationLoading) {
                    return Skeletonizer(
                      enabled: true,
                      child: Text(
                        "Cairo , Egypt",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: DeviceUtilsService.isTablet(context)
                              ? 15.sp
                              : 20.sp,
                        ),
                      ),
                    );
                  }
                  if (state is LocationSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.place,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontSize: DeviceUtilsService.isTablet(context)
                                    ? 15.sp
                                    : 20.sp,
                              ),
                        ),
                        Gap(4.h),
                        Text(
                          "${AppStrings.lastUpdated}: ${state.date.hour}:${state.date.minute} ${state.date.hour >= 12 ? "PM" : "AM"}",
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontSize: DeviceUtilsService.isTablet(context)
                                    ? 12.sp
                                    : 15.sp,
                              ),
                        ),
                      ],
                    );
                  }
                  return Text(
                    state is LocationFailure ? state.message : "",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: DeviceUtilsService.isTablet(context)
                          ? 15.sp
                          : 20.sp,
                    ),
                  );
                },
              ),
            ],
          ),
          BlocBuilder<GetTimingByCityCubit, GetTimingByCityState>(
            builder: (context, state) {
              if (state is GetTimingByCitySuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.timingEntity.hijriMonth,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: DeviceUtilsService.isTablet(context)
                            ? 12.sp
                            : 15.sp,
                      ),
                    ),
                    Text(
                      '${state.timingEntity.dayEn} ${state.timingEntity.hijriYear}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: DeviceUtilsService.isTablet(context)
                            ? 15.sp
                            : 20.sp,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      state.timingEntity.gregorianDate,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: DeviceUtilsService.isTablet(context)
                            ? 12.sp
                            : 15.sp,
                      ),
                    ),
                  ],
                );
              }
              if (state is GetTimingByCityFailure) {
                return Text(
                  state.error,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: DeviceUtilsService.isTablet(context)
                        ? 15.sp
                        : 20.sp,
                  ),
                );
              }
              if (state is GetTimingByCityLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.currentHijriDate,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: DeviceUtilsService.isTablet(context)
                              ? 12.sp
                              : 15.sp,
                        ),
                      ),
                      Text(
                        "Al Arba'a 1447",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: DeviceUtilsService.isTablet(context)
                              ? 15.sp
                              : 20.sp,
                        ),
                      ),
                      Text(
                        "25 Feb 2026",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
