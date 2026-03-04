import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:ummah/features/surah_details/presentation/cubit/saved_cubit.dart';
import 'package:ummah/features/surah_details/presentation/cubit/select_ayah_cubit.dart';
import 'package:ummah/features/surah_details/presentation/screens/widgets/mushaf_page_content.dart';
import 'package:ummah/core/constants/app_strings.dart';

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
                          "${AppStrings.juz} ${quran.ayahs.first.juz}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BlocBuilder<SavedCubit, SavedState>(
                          builder: (context, state) {
                            bool isThisPageSaved = false;
                            if (state is SavedSuccess) {
                              isThisPageSaved = state.savedPages.containsKey(
                                widget.pageNumber,
                              );
                            }
                            return IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                final surah = quran.allSurahs.firstWhere(
                                  (s) =>
                                      s.number == quran.ayahs.first.surahNumber,
                                );
                                context.read<SavedCubit>().toggleSave(
                                  widget.pageNumber,
                                  quran.ayahs.first.juz,
                                  surah.nameAr,
                                  surah.nameEn,
                                );
                              },
                              icon: Icon(
                                isThisPageSaved
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                size: 24.r,
                                color: isThisPageSaved
                                    ? Colors.amber
                                    : Theme.of(context).colorScheme.onSurface
                                          .withValues(alpha: 0.6),
                              ),
                            );
                          },
                        ),
                        Text(
                          "${AppStrings.page} ${widget.pageNumber}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.6),
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
