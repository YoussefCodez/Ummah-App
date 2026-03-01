import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/features/azkar/presentation/models/azkar_category.dart';
import 'package:ummah/features/azkar/presentation/screens/widgets/azkar_category_card.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final categories = [
      AzkarCategory(
        title: "أذكار الصباح",
        icon: "assets/svgs/sun.svg",
        baseColor: const Color(0xFFFFB74D), 
        count: "١٤ ذِكر",
      ),
      AzkarCategory(
        title: "أذكار المساء",
        icon: "assets/svgs/maghreeb.svg",
        baseColor: const Color(0xFF5C6BC0), 
        count: "٢٥ ذِكر",
      ),
      AzkarCategory(
        title: "أذكار الاستيقاظ",
        icon: "assets/svgs/sunrise.svg",
        baseColor: const Color(0xFF4DB6AC), 
        count: "١٠ أذكار",
      ),
      AzkarCategory(
        title: "أذكار النوم",
        icon: "assets/svgs/isah.svg",
        baseColor: const Color(0xFF263238), 
        count: "١٥ ذِكر",
      ),
      AzkarCategory(
        title: "بعد الصلاة",
        icon: "assets/svgs/tasbeeh.svg",
        baseColor: colorScheme.primary,
        count: "١٨ ذِكر",
      ),
      AzkarCategory(
        title: "أدعية عامة",
        icon: "assets/svgs/dua2.svg",
        baseColor: colorScheme.secondary,
        count: "٥٠ دعاء",
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220.h,
            backgroundColor: Colors.black.withValues(alpha: 0.6),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "حصن المسلم",
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/azkar_header.jpg"),
                    fit: .cover,
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
