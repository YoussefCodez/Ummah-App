import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:ummah/features/home/presentation/screens/widgets/access_services.dart';
import 'package:ummah/core/config/location_cubit.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/services/location_service.dart';
import 'package:ummah/features/home/domain/use_cases/get_timing_by_city_usecase.dart';
import 'package:ummah/features/home/presentation/cubit/get_timing_by_city_cubit.dart';
import 'package:ummah/features/home/presentation/screens/widgets/home_app_bar.dart';
import 'package:ummah/features/home/presentation/screens/widgets/prayers_widget.dart';
import 'package:ummah/features/home/presentation/screens/widgets/salah_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.controller});
  final PersistentTabController controller;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LocationCubit(getIt<LocationService>())..fetchGovernorate(),
        ),
        BlocProvider(
          create: (context) =>
              GetTimingByCityCubit(getIt<GetTimingByCityUsecase>()),
        ),
      ],
      child: BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationSuccess) {
            final parts = state.place.split(" ");
            final city = parts.isNotEmpty ? parts[0] : "Cairo";
            final country = parts.length > 1 ? parts[1] : "Egypt";
            context.read<GetTimingByCityCubit>().getTimingByCity(
              city: city,
              country: country,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).scaffoldBackgroundColor,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                HomeAppBar(),
                SalahRow(),
                PrayersWidget(),
                AccessServices(controller: controller),
                Gap(100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
