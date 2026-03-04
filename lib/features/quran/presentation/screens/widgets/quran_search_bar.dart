import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/constants/app_strings.dart';

class QuranSearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const QuranSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: AppStrings.searchPlaceholder,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: Theme.of(context).colorScheme.primary,
              size: 20.r,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15.h),
          ),
        ),
      ),
    );
  }
}
