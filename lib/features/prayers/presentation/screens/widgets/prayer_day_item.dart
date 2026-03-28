import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ummah/core/services/device_utils_service.dart';

class PrayerDayItem extends StatelessWidget {
  const PrayerDayItem({
    super.key,
    required this.day,
    required this.dayName,
    required this.isToday,
    required this.timings,
  });

  final String day;
  final String dayName;
  final bool isToday;
  final List<(String, String, String)> timings;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: isToday
            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            : Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: DeviceUtilsService.isTablet(context) ? 100.w : 80.w,
                padding: REdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isToday
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: isToday ? Colors.white : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      dayName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isToday ? Colors.white.withValues(alpha: 0.8) : Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Timings Grid
              Expanded(
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: timings.take(3).map((timing) {
                          return _buildTimeColumn(context, timing);
                        }).toList(),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: timings.skip(3).map((timing) {
                          return _buildTimeColumn(context, timing);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeColumn(BuildContext context, (String, String, String) timing) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          timing.$2,
          style: TextStyle(
            fontSize: 9.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: 4.h),
        SvgPicture.asset(
          timing.$1,
          width: 18.r,
          height: 18.r,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.secondary,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          timing.$3.split(' ')[0],
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          timing.$3.contains('AM') ? 'صباحاً' : 'مساءً',
          style: TextStyle(
            fontSize: 8.sp,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
