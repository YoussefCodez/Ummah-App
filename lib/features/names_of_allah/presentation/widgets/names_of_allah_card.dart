
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/names_of_allah/data/models/name_of_allah_model.dart';

class NameOfAllahCard extends StatelessWidget {
  final NameOfAllahModel name;
  final int index;
  
  const NameOfAllahCard({super.key, required this.name, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      margin: REdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: REdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  index.toString(),
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Gap(8.h),
            Text(
              name.nameAr,
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 48.sp,
                fontFamily: 'QuranFont',
              ),
              textAlign: TextAlign.center,
            ),
            Gap(8.h),
            Text(
              name.nameEn,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(20.h),
            Divider(color: colorScheme.primary.withValues(alpha: 0.2)),
            Gap(16.h),
            Text(
              name.meaningAr,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 18.sp,
                height: 1.6,
                fontFamily: 'QuranFont',
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            Gap(16.h),
            Text(
              name.meaningEn,
              style: TextStyle(
                color: AppColors.darkTextSecondary,
                fontSize: 15.sp,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(10.h),
          ],
        ),
      ),
    );
  }
}
