import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/features/quran/presentation/screens/widgets/saved_page_card.dart';
import 'package:ummah/features/surah_details/presentation/cubit/saved_cubit.dart';

class SavedPages extends StatelessWidget {
  const SavedPages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedCubit, SavedState>(
      builder: (context, state) {
        if (state is SavedSuccess && state.savedPages.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppStrings.savedPagesEn,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Main',
                  ),
                ),
              ),
              Gap(12.h),
              SizedBox(
                height: 130.h,
                child: ListView.separated(
                  padding: REdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.savedPages.length,
                  separatorBuilder: (context, index) => Gap(12.w),
                  itemBuilder: (context, index) {
                    final entity = state.savedPages.values.toList()[index];
                    return SavedPageCard(entity: entity);
                  },
                ),
              ),
              Gap(10.h),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
