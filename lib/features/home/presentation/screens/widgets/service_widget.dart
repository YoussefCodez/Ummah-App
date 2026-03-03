import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ummah/core/theme/app_colors.dart';

class Service extends StatelessWidget {
  const Service({super.key, required this.text, required this.icon, required this.onTap});
  final String text;
  final String icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: REdgeInsets.symmetric(horizontal: 10, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17.r),
            border: Border.all(
              color: Colors.grey.withAlpha(50),
              width: 1.w,
            ),
          ),
          child: Row(
            crossAxisAlignment: .center,
            children: [
              SvgPicture.asset(
                icon,
                height: 27.h,
                width: 27.w,
                fit: .cover,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              Gap(10.w),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: .w500,
                    color: AppColors.onThirdColor.withValues(alpha: .8),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18.r,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
