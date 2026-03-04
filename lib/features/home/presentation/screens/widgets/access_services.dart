import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:ummah/core/config/select_page_cubit.dart';
import 'package:ummah/features/dua/presentation/screens/dua_screen.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/features/home/presentation/screens/widgets/service_widget.dart';
import 'package:ummah/features/tasbih/presentation/screens/tasbih_screen.dart';

class AccessServices extends StatefulWidget {
  const AccessServices({super.key, required this.controller});
  final PersistentTabController controller;

  @override
  State<AccessServices> createState() => _AccessServicesState();
}

class _AccessServicesState extends State<AccessServices> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            AppStrings.quickAccess,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Row(
            spacing: 12.w,
            children: [
              Service(
                icon: "assets/svgs/quran.svg",
                text: AppStrings.quranEn,
                onTap: () {
                  context.read<SelectPageCubit>().selectPage(2);
                  widget.controller.jumpToTab(
                    context.read<SelectPageCubit>().state,
                  );
                },
              ),
              Service(
                icon: "assets/svgs/tasbeeh.svg",
                text: AppStrings.sebha,
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const TasbihScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.easeOutCubic;

                            var tween = Tween(
                              begin: begin,
                              end: end,
                            ).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            spacing: 12.w,
            children: [
              Service(
                icon: "assets/svgs/dua2.svg",
                text: AppStrings.dua,
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (context) => const DuaScreen()),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
