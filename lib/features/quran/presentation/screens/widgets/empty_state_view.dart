
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            color: Colors.grey[300],
          ),
          Gap(10.h),
          Text(
            "Can't find any surah",
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
