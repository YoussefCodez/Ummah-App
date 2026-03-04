import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/features/azkar/domain/entities/azkar_category.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/features/azkar/presentation/screens/widgets/azkar_category_card.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final categories = [
      AzkarCategory(
        title: AppStrings.morningAzkar,
        icon: Icons.wb_sunny_rounded,
        baseColor: const Color(0xFFFFB74D),
        count: "٢٢ ذِكر",
      ),
      AzkarCategory(
        title: AppStrings.eveningAzkar,
        icon: Icons.dark_mode_rounded,
        baseColor: const Color(0xFF5C6BC0),
        count: "٢٦ ذِكر",
      ),
      AzkarCategory(
        title: AppStrings.foodAzkar,
        icon: Icons.restaurant_rounded,
        baseColor: const Color(0xFF81C784),
        count: "٨ أذكار",
      ),
      AzkarCategory(
        title: AppStrings.mosqueAzkar,
        icon: Icons.mosque_rounded,
        baseColor: const Color(0xFF4DB6AC),
        count: "٦ أذكار",
      ),
      AzkarCategory(
        title: AppStrings.homeAzkar,
        icon: Icons.home_rounded,
        baseColor: const Color(0xFFA1887F),
        count: "٤ أذكار",
      ),
      AzkarCategory(
        title: AppStrings.wakingUpAzkar,
        icon: Icons.wb_twilight_rounded,
        baseColor: const Color(0xFFFFF176),
        count: "١٠ أذكار",
      ),
      AzkarCategory(
        title: AppStrings.protectionAzkar,
        icon: Icons.shield_rounded,
        baseColor: const Color(0xFFE57373),
        count: "١٢ ذِكر",
      ),
      AzkarCategory(
        title: AppStrings.travelAzkar,
        icon: Icons.flight_takeoff_rounded,
        baseColor: const Color(0xFF64B5F6),
        count: "٩ أذكار",
      ),
      AzkarCategory(
        title: AppStrings.feelingsAzkar,
        icon: Icons.favorite_rounded,
        baseColor: const Color(0xFFBA68C8),
        count: "١٥ ذِكر",
      ),
      AzkarCategory(
        title: AppStrings.prayerAzkar,
        icon: Icons.pan_tool_alt_rounded,
        baseColor: const Color(0xFF9575CD),
        count: "١٨ ذِكر",
      ),
      AzkarCategory(
        title: AppStrings.wuduAzkar,
        icon: Icons.water_drop_rounded,
        baseColor: const Color(0xFF4FC3F7),
        count: "٥ أذكار",
      ),
      AzkarCategory(
        title: AppStrings.natureAzkar,
        icon: Icons.eco_rounded,
        baseColor: const Color(0xFFDCE775),
        count: "٧ أذكار",
      ),
      AzkarCategory(
        title: AppStrings.fastingAzkar,
        icon: Icons.nights_stay_rounded,
        baseColor: const Color(0xFFFF8A65),
        count: "٤ أذكار",
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220.h,
            backgroundColor: Colors.black.withValues(alpha: 0.6),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                AppStrings.hisnAlMuslim,
                style: textTheme.titleLarge?.copyWith(
                  fontFamily: 'QuranFont',
                  color: Colors.white,
                  shadows: [
                    const Shadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/azkar_header.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(20.r),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 15.w,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final cat = categories[index];
                return AzkarCategoryCard(category: cat, index: index);
              }, childCount: categories.length),
            ),
          ),
          SliverToBoxAdapter(child: Gap(100.h)),
        ],
      ),
    );
  }
}
