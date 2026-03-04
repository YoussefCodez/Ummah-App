import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/features/quran/domain/entities/saved_page_entity.dart';
import 'package:ummah/features/surah_details/presentation/screens/mushaf_screen.dart';
import 'package:ummah/core/constants/app_strings.dart';

class SavedPageCard extends StatelessWidget {
  final SavedPageEntity entity;
  const SavedPageCard({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => MushafScreen(initialPage: entity.pageNumber),
          ),
        );
      },
      child: Container(
        width: 260.w,
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              entity.surahNameEn,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Main',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Gap(8.w),
                          Text(
                            entity.surahName,
                            style: TextStyle(
                              fontFamily: 'Main',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Gap(4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.menu_book_rounded,
                            size: 14.sp,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          Gap(4.w),
                          Text(
                            "${AppStrings.pageEn} ${entity.pageNumber}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.6),
                              fontFamily: 'Main',
                            ),
                          ),
                        ],
                      ),
                      Gap(2.h),
                      Row(
                        children: [
                          Icon(
                            Icons.layers_rounded,
                            size: 14.sp,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          Gap(4.w),
                          Text(
                            "${AppStrings.juzEn} ${entity.juzNumber}",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.5),
                              fontFamily: 'Main',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Image.asset(
                  "assets/images/quran.png",
                  fit: BoxFit.contain,
                  scale: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
