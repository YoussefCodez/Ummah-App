import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:ummah/core/config/select_page_cubit.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/home/presentation/screens/widgets/service_widget.dart';

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
        crossAxisAlignment: .start,
        spacing: 10.h,
        children: [
          Text(
            "Quick Access",
            style: TextStyle(
              fontSize: 23.sp,
              fontWeight: .bold,
              color: AppColors.primaryColor,
            ),
          ),
          Row(
            spacing: 10.h,
            children: [
              Service(
                icon: "assets/svgs/quran.svg",
                text: "Quran",
                onTap: () {
                  context.read<SelectPageCubit>().selectPage(2);
                  widget.controller.jumpToTab(
                    context.read<SelectPageCubit>().state,
                  );
                },
              ),
              Service(
                icon: "assets/svgs/tasbeeh.svg",
                text: "Sebha",
                onTap: () {},
              ),
            ],
          ),
          Row(
            spacing: 10.h,
            children: [
              Service(icon: "assets/svgs/dua2.svg", text: "Dua", onTap: () {}),
              Service(
                icon: "assets/svgs/hadeeth.svg",
                text: "Ahadith",
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
