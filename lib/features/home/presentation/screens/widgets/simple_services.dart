
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/home/presentation/screens/widgets/staggered_service.dart';
import 'package:ummah/features/names_of_allah/presentation/screens/names_of_allah_screen.dart';
import 'package:ummah/features/ayat_al_kursi/presentation/screens/ayat_al_kursi_screen.dart';

class SimpleServices extends StatelessWidget {
  const SimpleServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          Divider(color: AppColors.darkOnSecondary),
          Gap(20.h),
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 2,
                child: StaggeredService(
                  text: AppStrings.mosques,
                  image: "assets/images/masjid_1.jpeg",
                  onTap: () {
                    print("D");
                  },
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: StaggeredService(
                  text: AppStrings.namesOfAllah,
                  image: "assets/images/sky_1.jpeg",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NamesOfAllahScreen(),
                      ),
                    );
                  },
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: StaggeredService(
                  text: AppStrings.ayatAlKursi,
                  image: "assets/images/quran_2.jpeg",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AyatAlKursiScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
