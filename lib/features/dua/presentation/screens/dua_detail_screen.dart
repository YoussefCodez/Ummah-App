import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/dua/domain/models/dua_entity.dart';
import 'package:ummah/features/dua/presentation/screens/widgets/dua_item_card.dart';

class DuaDetailScreen extends StatelessWidget {
  final DuaCategory category;

  const DuaDetailScreen({super.key, required this.category});

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
            color: AppColors.primaryColor,
          ),
          iconSize: 20.r,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          category.name,
          style: TextStyle(
            fontFamily: 'Main',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.r),
        itemCount: category.duas.length,
        separatorBuilder: (context, index) => Gap(15.h),
        itemBuilder: (context, index) {
          return DuaItemCard(dua: category.duas[index]);
        },
      ),
    );
  }
}
