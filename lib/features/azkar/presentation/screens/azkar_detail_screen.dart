import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/features/azkar/presentation/cubit/azkar_cubit.dart';
import 'package:ummah/features/azkar/presentation/cubit/azkar_state.dart';
import 'package:ummah/features/azkar/presentation/screens/widgets/azkar_item_card.dart';

class AzkarDetailScreen extends StatelessWidget {
  final String title;
  final int index;
  const AzkarDetailScreen({
    super.key,
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit()..loadAzkar(index),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Text(title, style: const TextStyle(fontFamily: 'Main')),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<AzkarCubit>().resetAll();
                  },
                  icon: const Icon(Icons.refresh),
                  tooltip: 'إعادة تعيين الكل',
                ),
              ],
            ),
            body: BlocBuilder<AzkarCubit, AzkarState>(
              builder: (context, state) {
                if (state is AzkarLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          padding: REdgeInsets.all(20),
                          itemCount: state.azkarList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => Gap(20.h),
                          itemBuilder: (context, index) {
                            final zikr = state.azkarList[index];
                            final count = state.currentCounts[index];
                            return AzkarItemCard(
                              text: zikr.text,
                              count: count,
                              maxCount: zikr.repeat,
                              source:
                                  (zikr.reference != null &&
                                      zikr.reference!.isNotEmpty)
                                  ? zikr.reference
                                  : null,
                              onTap: () {
                                context.read<AzkarCubit>().decrementZikr(index);
                              },
                              onReset: () {
                                context.read<AzkarCubit>().resetZikr(index);
                              },
                            );
                          },
                        ),
                        Gap(100.h),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          );
        },
      ),
    );
  }
}
