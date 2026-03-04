import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/features/tasbih/presentation/cubit/tasbeeh_cubit.dart';
import 'package:ummah/features/tasbih/presentation/cubit/vibration_cubit.dart';
import 'package:ummah/features/tasbih/presentation/screens/widgets/tasbih_round_button.dart';

class TasbihActionButtons extends StatelessWidget {
  const TasbihActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TasbihRoundButton(
            icon: Icons.refresh_rounded,
            label: AppStrings.resetLabel,
            onTap: () {
              context.read<TasbeehCubit>().reset();
            },
          ),
          BlocBuilder<VibrationCubit, bool>(
            builder: (context, state) {
              return TasbihRoundButton(
                icon: state
                    ? Icons.vibration_rounded
                    : Icons
                          .vibration_rounded, // Assuming icon changes or indicating state
                label: AppStrings.vibrationLabel,
                onTap: () {
                  context.read<VibrationCubit>().toggleVibration();
                },
                isActive: state,
              );
            },
          ),
        ],
      ),
    );
  }
}
