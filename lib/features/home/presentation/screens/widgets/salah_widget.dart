import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ummah/core/services/device_utils_service.dart';

class SalahWidget extends StatelessWidget {
  const SalahWidget({
    super.key,
    required this.svg,
    required this.title,
    required this.time,
    required this.isActive,
    required this.isNext,
  });
  final String svg;
  final String title;
  final String time;
  final bool isActive;
  final bool isNext;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: REdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          SvgPicture.asset(
            svg,
            height: 24.h,
            width: 24.w,
            colorFilter: ColorFilter.mode(
              isActive
                  ? Colors.white
                  : Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            ),
          ),
          Gap(8.h),
          Text(
            title,
            style: TextStyle(
              color: isActive
                  ? Colors.white
                  : Theme.of(context).colorScheme.secondary,
              fontSize: DeviceUtilsService.isTablet(context) ? 12.sp : 15.sp,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
            ),
          ),
          Gap(8.h),
          Text(
            time,
            style: TextStyle(
              color: isActive
                  ? Colors.white
                  : Theme.of(context).colorScheme.secondary,
              fontSize: DeviceUtilsService.isTablet(context) ? 12.sp : 15.sp,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
