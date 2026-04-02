import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/features/names_of_allah/data/data_sources/names_of_allahlocal_data_source.dart';
import 'package:ummah/features/names_of_allah/data/models/name_of_allah_model.dart';
import 'package:ummah/features/names_of_allah/presentation/widgets/names_of_allah_card.dart';

class NamesOfAllahScreen extends StatelessWidget {
  const NamesOfAllahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    List<NameOfAllahModel> names = NamesOfAllahLocalDataSource.namesOfAllah;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          AppStrings.namesOfAllah,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      body: ListView.builder(
        padding: REdgeInsets.all(16),
        itemCount: names.length,
        itemBuilder: (context, index) {
          final name = names[index];
          return NameOfAllahCard(name: name, index: index + 1);
        },
      ),
    );
  }
}
