import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:quran_with_tafsir/quran_with_tafsir.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/surah_details/presentation/cubit/is_playing_ayah_cubit.dart';
import 'package:ummah/features/surah_details/presentation/cubit/quran_tafsir_cubit.dart';
import 'package:ummah/features/surah_details/presentation/cubit/select_ayah_cubit.dart';
import 'package:ummah/features/surah_details/presentation/screens/widgets/ayah_bottom_sheet.dart';
import 'package:ummah/features/surah_details/presentation/screens/widgets/bismillah_widget.dart';
import 'package:ummah/features/surah_details/presentation/screens/widgets/surah_header.dart';

class MushafPageContent extends StatelessWidget {
  final List<Ayah> ayahs;
  final String selectedAyahKey;
  final List<SurahMetadata> allSurahs;

  const MushafPageContent({
    super.key,
    required this.ayahs,
    required this.selectedAyahKey,
    required this.allSurahs,
  });

  void _showAyahDetails(BuildContext context, Ayah ayah) {
    // تحميل التفسير للسورة الحالية
    context.read<QuranTafsirCubit>().loadTafsir(ayah.surahNumber);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<QuranTafsirCubit>()),
          BlocProvider.value(value: context.read<QuranCubit>()),
          BlocProvider(create: (context) => IsPlayingAyahCubit()),
        ],
        child: AyahBottomSheet(ayah: ayah),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];
    int? currentSurah;
    List<InlineSpan> spans = [];

    for (var i = 0; i < ayahs.length; i++) {
      final ayah = ayahs[i];
      final currentAyahKey = "${ayah.surahNumber}_${ayah.id}";
      final isSelected = currentAyahKey == selectedAyahKey;

      if (currentSurah != ayah.surahNumber) {
        if (spans.isNotEmpty) {
          content.add(_RichTextWidget(spans: spans));
          spans = [];
        }

        currentSurah = ayah.surahNumber;
        final surahMeta = allSurahs.firstWhere(
          (s) => s.number == currentSurah,
          orElse: () => SurahMetadata(
            number: currentSurah!,
            nameAr: "سورة",
            nameEn: "Surah",
            revelationType: "",
            ayahCount: 0,
          ),
        );
        content.add(SurahHeader(surah: surahMeta));

        if (ayah.id == 1 && currentSurah != 1 && currentSurah != 9) {
          content.add(const BismillahWidget());
        }
      }

      spans.add(
        TextSpan(
          text: "${ayah.text} ",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              context.read<SelectAyahCubit>().selectAyah(
                ayah.surahNumber,
                ayah.id,
              );
              _showAyahDetails(context, ayah);
            },
          style: TextStyle(
            fontFamily: 'QuranFont',
            fontSize: 25.sp,
            height: 2.0,
            backgroundColor: isSelected
                ? AppColors.primaryColor.withValues(alpha: 0.2)
                : Colors.transparent,
            color: Colors.black87,
          ),
        ),
      );
    }

    if (spans.isNotEmpty) {
      content.add(_RichTextWidget(spans: spans));
    }

    return Column(children: content);
  }
}

class _RichTextWidget extends StatelessWidget {
  final List<InlineSpan> spans;
  const _RichTextWidget({required this.spans});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: spans),
      textAlign: TextAlign.justify,
      textDirection: TextDirection.rtl,
    );
  }
}
