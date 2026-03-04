import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:ummah/core/config/select_page_cubit.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/calendar/screens/calendar_screen.dart';
import 'package:ummah/features/home/presentation/screens/home_screen.dart';
import 'package:ummah/features/azkar/presentation/screens/azkar_screen.dart';
import 'package:ummah/features/quran/presentation/screens/quran_screen.dart';
import 'package:ummah/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(
      initialIndex: context.read<SelectPageCubit>().state,
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(controller: _controller),
      const AzkarScreen(),
      const QuranScreen(),
      const CalendarScreen(),
      const SettingsScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/svgs/masjid_icon.svg",
          height: 28.w,
          width: 28.w,
          colorFilter: ColorFilter.mode(
            _controller.index == 0
                ? AppColors.primaryColor
                : const Color(0xff9E9E9E),
            BlendMode.srcIn,
          ),
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: const Color(0xff9E9E9E),
        iconSize: 28.w,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.book, size: 28.w),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: const Color(0xff9E9E9E),
        iconSize: 28.w,
      ),
      PersistentBottomNavBarItem(
        icon: Padding(
          padding: REdgeInsets.all(3.5),
          child: SvgPicture.asset(
            "assets/svgs/quran.svg",
            height: 45.w,
            width: 45.w,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: const Color(0xff9E9E9E),
        iconSize: 45.w,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.calendar, size: 28.w),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: const Color(0xff9E9E9E),
        iconSize: 28.w,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings, size: 28.w),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: const Color(0xff9E9E9E),
        iconSize: 28.w,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectPageCubit, int>(
      builder: (context, state) {
        return PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineToSafeArea: true,
          backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          navBarHeight: 60.h,
          onItemSelected: (index) {
            context.read<SelectPageCubit>().selectPage(index);
          },
          hideNavigationBarWhenKeyboardAppears: true,
          animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation: ItemAnimationSettings(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimationSettings(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              duration: Duration(milliseconds: 250),
              screenTransitionAnimationType:
                  ScreenTransitionAnimationType.fadeIn,
            ),
          ),
          margin: REdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(25.r),
            colorBehindNavBar: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(80),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          navBarStyle: NavBarStyle.style15,
        );
      },
    );
  }
}
