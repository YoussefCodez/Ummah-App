import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_state.dart';

class BismillahWidget extends StatelessWidget {
  const BismillahWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ",
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'QuranFont',
              fontSize: state.settings.textFontSize.sp,
              color: Colors.black,
            ),
          ),
        );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
