import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:ummah/features/surah_details/presentation/cubit/select_ayah_cubit.dart';
import 'package:ummah/features/surah_details/presentation/screens/widgets/mushaf_page_content.dart';

class MushafPage extends StatefulWidget {
  const MushafPage({super.key, required this.pageNumber});
  final int pageNumber;

  @override
  State<MushafPage> createState() => _MushafPageState();
}

class _MushafPageState extends State<MushafPage> {
  @override
  void initState() {
    super.initState();
    context.read<QuranCubit>().loadPage(widget.pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      buildWhen: (previous, current) {
        if (current is QuranPageLoading) {
          return current.pageNumber == widget.pageNumber;
        }
        if (current is QuranPageSuccess) {
          return current.pageNumber == widget.pageNumber;
        }
        if (current is QuranPageFailure) {
          return true;
        }
        return false;
      },
      builder: (context, quran) {
        if (quran is QuranPageLoading &&
            quran.pageNumber == widget.pageNumber) {
          return const Center(child: CircularProgressIndicator());
        } else if (quran is QuranPageSuccess &&
            quran.pageNumber == widget.pageNumber) {
          return BlocBuilder<SelectAyahCubit, String>(
            builder: (context, selectedAyahKey) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.all(20.r),
                      child: MushafPageContent(
                        ayahs: quran.ayahs,
                        selectedAyahKey: selectedAyahKey,
                        allSurahs: quran.allSurahs,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "الجزء ${quran.ayahs.first.juz}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "صفحة ${widget.pageNumber}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        } else if (quran is QuranPageFailure) {
          return Center(child: Text(quran.message));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
