import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/tasbih/presentation/cubit/tasbeeh_cubit.dart';
import 'package:ummah/features/tasbih/presentation/cubit/vibration_cubit.dart';
import 'package:vibration/vibration.dart';

class TasbihCounterDisplay extends StatelessWidget {
  const TasbihCounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasbeehCubit, TasbeehState>(
      builder: (context, state) {
        return BlocBuilder<VibrationCubit, bool>(
          builder: (context, vibrationState) {
            return GestureDetector(
              onTap: () {
                context.read<TasbeehCubit>().increment();
                if (vibrationState) {
                  Vibration.vibrate(duration: 100);
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Glow
                  Container(
                    width: 280.r,
                    height: 280.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primaryColor.withValues(alpha: 0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 240.r,
                    height: 240.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.1),
                        width: 10,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withValues(alpha: 0.2),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.currentCount.toString(),
                          style: TextStyle(
                            fontFamily: 'Main',
                            fontSize: 70.sp,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(
                          '${state.currentTarget} Time\'s',
                          style: TextStyle(
                            fontFamily: 'Main',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.onPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Circular Progress Indicator
                  SizedBox(
                    width: 260.r,
                    height: 260.r,
                    child: CircularProgressIndicator(
                      value: state.progress,
                      strokeWidth: 8,
                      strokeCap: StrokeCap.round,
                      backgroundColor: AppColors.primaryColor.withValues(
                        alpha: 0.1,
                      ),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
