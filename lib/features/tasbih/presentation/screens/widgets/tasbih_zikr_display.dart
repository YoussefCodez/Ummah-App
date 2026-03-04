import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/tasbih/presentation/cubit/tasbeeh_cubit.dart';

class TasbihZikrDisplay extends StatelessWidget {
  const TasbihZikrDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: REdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: BlocBuilder<TasbeehCubit, TasbeehState>(
        builder: (context, state) {
          return Column(
            children: [
              Text(
                state.currentZikrAr,
                style: TextStyle(
                  fontFamily: 'QuranFont',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(5.h),
              Text(
                state.currentZikrEn,
                style: TextStyle(
                  fontFamily: 'Main',
                  fontSize: 12.sp,
                  color: AppColors.onPrimaryColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
