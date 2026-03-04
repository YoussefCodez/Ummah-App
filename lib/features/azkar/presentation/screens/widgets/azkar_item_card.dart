import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarItemCard extends StatelessWidget {
  final String text;
  final int count;
  final int maxCount;
  final String? source;
  final VoidCallback onTap;
  final VoidCallback onReset;

  const AzkarItemCard({
    super.key,
    required this.text,
    required this.count,
    required this.maxCount,
    this.source,
    required this.onTap,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDone = count == 0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDone
            ? Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
            : Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: isDone
              ? Colors.transparent
              : theme.colorScheme.primary.withValues(alpha: 0.1),
          width: 2,
        ),
        boxShadow: [
          if (!isDone)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
        ],
      ),
      child: Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'QuranFont',
              fontSize: 24.sp,
              height: 1.8,
              color: isDone
                  ? Theme.of(context).colorScheme.outlineVariant
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          if (source != null) ...[
            Gap(15.h),
            Text(
              source!,
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.outline,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          Gap(25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onReset,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  Icons.refresh,
                  color: isDone
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outlineVariant,
                  size: 20.r,
                ),
              ),
              GestureDetector(
                onTap: isDone ? null : onTap,
                child: Container(
                  height: 60.r,
                  width: 120.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDone
                          ? [
                              Theme.of(context).colorScheme.outlineVariant,
                              Theme.of(context).colorScheme.outline,
                            ]
                          : [
                              theme.colorScheme.primary,
                              theme.colorScheme.primary.withValues(alpha: 0.7),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      if (!isDone)
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.3,
                          ),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "$count / $maxCount",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40.w),
            ],
          ),
        ],
      ),
    );
  }
}
