import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ummah/core/services/device_utils_service.dart';
import 'package:ummah/features/azkar/domain/entities/azkar_category.dart';
import 'package:ummah/features/azkar/presentation/screens/azkar_detail_screen.dart';

class AzkarCategoryCard extends StatelessWidget {
  final AzkarCategory category;
  final int index;
  const AzkarCategoryCard({
    super.key,
    required this.category,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: category.baseColor.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.r),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AzkarDetailScreen(title: category.title, index: index),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  clipBehavior: .antiAlias,
                  decoration: BoxDecoration(
                    color: category.baseColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    category.icon,
                    size: 35.w,
                    color: category.baseColor,
                  ),
                ),
                Gap(12.h),
                Text(
                  category.title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: .bold,
                    fontFamily: 'Main',
                    fontSize: DeviceUtilsService.isTablet(context)
                        ? 13.sp
                        : 14.sp,
                  ),
                ),
                Gap(4.h),
                Text(
                  category.count,
                  style: GoogleFonts.cairo(
                    fontSize: DeviceUtilsService.isTablet(context)
                        ? 10.sp
                        : 12.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
