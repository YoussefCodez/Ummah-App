import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_with_tafsir/services/quran_service.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/features/ayat_al_kursi/presentation/widgets/english_translation_expansion.dart';
import 'package:ummah/features/ayat_al_kursi/presentation/widgets/expansion_info_card.dart';
import 'package:ummah/features/ayat_al_kursi/presentation/widgets/rich_text_content.dart';
import 'package:ummah/features/ayat_al_kursi/data/data_sources/ayat_al_kursi_local_data_source.dart';
import 'package:ummah/features/quran/presentation/cubit/quran_cubit.dart';

class AyatAlKursiScreen extends StatefulWidget {
  const AyatAlKursiScreen({super.key});

  @override
  State<AyatAlKursiScreen> createState() => _AyatAlKursiScreenState();
}

class _AyatAlKursiScreenState extends State<AyatAlKursiScreen> {
  final player = AudioPlayer();
  final quran = QuranService.instance;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    player.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });
    player.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> _toggleAudio() async {
    try {
      final quranCubit = getIt<QuranCubit>(); 
      if (_isPlaying) {
        await player.pause();
      } else {
        final url = quranCubit.getAudioUrl(
                2,
                255,
              );
              quranCubit.loadAudio(url);
        // String? audioUrl = quran.getAyah(2, 255).audioUrl;
        // print(audioUrl);
        // audioUrl ??= "https://everyayah.com/data/Alafasy_128kbps/002255.mp3";
        // await player.play(UrlSource(audioUrl));
      }
    } catch (e) {
      debugPrint("Error playing audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final ayat = AyatAlKursiLocalDataSource.ayatulKursi;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          AppStrings.ayatAlKursi,
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
      body: SingleChildScrollView(
        padding: REdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: REdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      ayat.titleAr,
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Gap(24.h),
                  Text(
                    ayat.textAr,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 28.sp,
                      height: 1.8,
                      fontFamily: 'QuranFont',
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  Gap(15.h),
                  CircleAvatar(
                    radius: 28.r,
                    backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
                    child: IconButton(
                      iconSize: 32.sp,
                      icon: Icon(
                        _isPlaying 
                          ? Icons.pause_rounded 
                          : Icons.play_arrow_rounded,
                        color: colorScheme.primary,
                      ),
                      onPressed: _toggleAudio,
                    ),
                  ),
                  Gap(16.h),
                  EnglishTranslationExpansion(textEn: ayat.textEn),
                  Gap(10.h),
                ],
              ),
            ),
            Gap(16.h),
            ExpansionInfoCard(
              title: AppStrings.benefitsAyatAlKursi,
              content: RichTextContent(data: ayat.benefits),
            ),
            Gap(16.h),
            ExpansionInfoCard(
              title: AppStrings.greatnessAyatAlKursi,
              content: RichTextContent(data: ayat.story),
            ),
            Gap(16.h),
            ExpansionInfoCard(
              title: AppStrings.tafsirMuyassar,
              content: Text(
                ayat.tafsirAlMuyassar,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16.sp,
                  height: 1.8,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
            Gap(16.h),
            ExpansionInfoCard(
              title: AppStrings.mukhtasar,
              content: Text(
                ayat.mukhtasar,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16.sp,
                  height: 1.8,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
            Gap(100.h),
          ],
        ),
      ),
    );
  }
}
