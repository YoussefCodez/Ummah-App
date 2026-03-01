import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_with_tafsir/quran_with_tafsir.dart';
import 'package:ummah/core/theme/app_colors.dart';

class SurahTile extends StatelessWidget {
  final SurahMetadata surah;
  final VoidCallback onTap;

  const SurahTile({super.key, required this.surah, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                _buildSurahNumber(),
                Gap(16.w),
                Expanded(child: _buildSurahInfo()),
                _buildSurahNameAr(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSurahNumber() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.brightness_7,
          size: 38.r,
          color: AppColors.primaryColor.withValues(alpha: 0.15),
        ),
        Text(
          surah.number.toString(),
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSurahInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          surah.nameEn,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.onThirdColor,
          ),
        ),
        Gap(4.h),
        Row(
          children: [
            _buildTypeIcon(),
            Gap(6.w),
            Text(
              "${surah.revelationType} • ${surah.ayahCount} آية",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSurahNameAr() {
    return Text(
      surah.nameAr,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
        fontFamily: 'Main',
      ),
    );
  }

  Widget _buildTypeIcon() {
    final isMeccan = surah.revelationType?.toLowerCase() == 'meccan';
    return Icon(
      isMeccan ? Icons.location_on : Icons.mosque,
      size: 14.r,
      color: Colors.orange[300],
    );
  }
}
