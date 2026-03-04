import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gap/flutter_gap.dart';

class TasbihRoundButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const TasbihRoundButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15.r),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                  color: isActive
                      ? Colors.transparent
                      : Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.1),
                ),
              ),
              child: Icon(
                icon,
                color: isActive
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
                size: 24.r,
              ),
            ),
          ),
        ),
        Gap(8.h),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Main',
            fontSize: 12.sp,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
