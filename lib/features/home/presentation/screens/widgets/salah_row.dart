import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/features/home/presentation/cubit/get_timing_by_city_cubit.dart';
import 'package:ummah/features/home/presentation/screens/widgets/salah_widget.dart';

class SalahRow extends StatelessWidget {
  const SalahRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.onPrimaryFixed,
          padding: REdgeInsets.all(16),
          child: BlocBuilder<GetTimingByCityCubit, GetTimingByCityState>(
            buildWhen: (previous, current) {
              return previous != current;
            },
            builder: (context, state) {
              if (state is GetTimingByCityLoading) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (state is GetTimingByCityFailure) {
                return Center(child: Text(state.error));
              }
              if (state is GetTimingByCitySuccess) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(state.salwat.length, (index) {
                    final currentSalah = state.salwat[index];
                    return Expanded(
                      child: SalahWidget(
                        svg: currentSalah.svg,
                        title: currentSalah.name,
                        time: state.timingEntity.convertTo12Hour(
                          currentSalah.timeStr,
                        ),
                        isActive: index == state.activeAndNextIndex.$1,
                        isNext: index == state.activeAndNextIndex.$2,
                      ),
                    );
                  }),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
