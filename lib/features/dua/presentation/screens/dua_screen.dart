import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/features/dua/domain/models/dua_entity.dart';
import 'package:ummah/features/dua/presentation/screens/dua_detail_screen.dart';
import 'package:ummah/features/dua/presentation/screens/widgets/dua_category_card.dart';

class DuaScreen extends StatelessWidget {
  const DuaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          AppStrings.classifiedDuas,
          style: TextStyle(
            fontFamily: 'Main',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Gap(10.h)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 15.w,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final category = duaCategories[index];
                return DuaCategoryCard(
                  category: category,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DuaDetailScreen(category: category),
                      ),
                    );
                  },
                );
              }, childCount: duaCategories.length),
            ),
          ),
        ],
      ),
    );
  }
}
