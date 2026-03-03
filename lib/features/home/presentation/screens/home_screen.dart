import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:ummah/core/config/location_cubit.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/features/home/presentation/cubit/get_timing_by_city_cubit.dart';
import 'package:ummah/features/home/presentation/screens/widgets/access_services.dart';
import 'package:ummah/features/home/presentation/screens/widgets/home_app_bar.dart';
import 'package:ummah/features/home/presentation/screens/widgets/prayers_widget.dart';
import 'package:ummah/features/home/presentation/screens/widgets/salah_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});
  final PersistentTabController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LocationCubit _locationCubit;
  late GetTimingByCityCubit _timingCubit;

  @override
  void initState() {
    super.initState();
    _locationCubit = getIt<LocationCubit>();
    _timingCubit = getIt<GetTimingByCityCubit>();

    // Initial fetch
    _locationCubit.fetchGovernorate();

    // Check if location is already arrived (from singleton cache)
    if (_locationCubit.state is LocationSuccess) {
      _triggerTimingFetch((_locationCubit.state as LocationSuccess).place);
    }
  }

  void _triggerTimingFetch(String place) {
    final parts = place.split(", ");
    final city = parts.isNotEmpty ? parts[0] : "Cairo";
    final country = parts.length > 1 ? parts[1] : "Egypt";
    _timingCubit.getTimingByCity(city: city, country: country);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _locationCubit),
        BlocProvider.value(value: _timingCubit),
      ],
      child: BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationSuccess) {
            _triggerTimingFetch(state.place);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBar(),
                const SalahRow(),
                const PrayersWidget(),
                AccessServices(controller: widget.controller),
                Gap(100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
