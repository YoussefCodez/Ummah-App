import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/constants/app_strings.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.search_circle,
            size: 80.r,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          Gap(10.h),
          Text(
            AppStrings.noSurahFound,
            style: TextStyle(
              fontSize: 16.sp,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
