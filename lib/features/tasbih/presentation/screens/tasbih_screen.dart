import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/features/tasbih/presentation/cubit/tasbeeh_cubit.dart';
import 'package:ummah/features/tasbih/presentation/screens/widgets/tasbih_action_buttons.dart';
import 'package:ummah/features/tasbih/presentation/screens/widgets/tasbih_counter_display.dart';
import 'package:ummah/features/tasbih/presentation/screens/widgets/tasbih_zikr_display.dart';
import 'package:ummah/features/tasbih/presentation/cubit/vibration_cubit.dart';

class TasbihScreen extends StatelessWidget {
  const TasbihScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasbeehCubit()),
        BlocProvider(create: (context) => VibrationCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            iconSize: 20.r,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            AppStrings.sebha,
            style: TextStyle(
              fontFamily: 'Main',
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: Column(
          children: [
            Gap(40.h),
            const TasbihZikrDisplay(),
            const Spacer(),
            const TasbihCounterDisplay(),
            const Spacer(),
            const TasbihActionButtons(),
          ],
        ),
      ),
    );
  }
}
