import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/core/theme/app_colors.dart';

class EnglishTranslationExpansion extends StatefulWidget {
  final String textEn;
  const EnglishTranslationExpansion({super.key, required this.textEn});

  @override
  State<EnglishTranslationExpansion> createState() =>
      _EnglishTranslationExpansionState();
}

class _EnglishTranslationExpansionState
    extends State<EnglishTranslationExpansion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Divider(color: colorScheme.onSurfaceVariant.withValues(alpha: 0.15)),
        Gap(8.h),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.englishTranslation,
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Gap(8.w),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(
            width: double.infinity,
          ),
          secondChild: Container(
            padding: REdgeInsets.only(top: 16),
            width: double.infinity,
            child: Text(
              widget.textEn,
              style: TextStyle(
                color: AppColors.darkTextSecondary,
                fontSize: 16.sp,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.topCenter,
        ),
      ],
    );
  }
}
