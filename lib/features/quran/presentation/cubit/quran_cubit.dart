import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:quran_with_tafsir/quran_with_tafsir.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; 

part 'quran_state.dart';

@injectable
class QuranCubit extends Cubit<QuranState> {
  // خدمة القرآن لجلب البيانات والروابط
  final QuranService _quranService;

  // قائمة مرجعية لجميع السور لاستخدامها في البحث والفلترة
  late List<SurahMetadata> _allSurahs = [];

  // مشغل الصوت الرئيسي (نسخة واحدة دائمة)
  final AudioPlayer _audioPlayer = AudioPlayer();

  // تتبع السورة والآية التي تعمل حالياً صوتياً
  int? _currentSurahNum;
  int? _currentAyahNum;

  // حالة التشغيل الحالية
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  // جسر التواصل مع الواجهة لتحديث التظليل والتقليب (السورة، الـ ID، الصفحة)
  void Function(int surah, int ayah, int page)? onAyahChanged;

  QuranCubit(this._quranService) : super(QuranInitial()) {
    // الاستماع لانتهاء المفعول الصوتي لتشغيل الآية التالية تلقائياً
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextAyah();
    });
  }

  // تحميل سورة محددة وعمل Emit لحالة النجاح
  void loadSpecificSurah(int surahNumber) {
    try {
      emit(QuranSurahLoading());
      final _surah = _quranService.getSurah(surahNumber);
      emit(QuranSurahSuccess(surah: _surah));
    } catch (e) {
      emit(QuranSurahFailure(message: e.toString()));
    }
  }

  // معرفة رقم أول صفحة تبدأ فيها السورة
  int getSurahStartPage(int surahNumber) {
    final surah = _quranService.getSurah(surahNumber);
    return surah.verses.first.page;
  }

  // تحميل كافة الآيات الموجودة في صفحة معينة من المصحف
  void loadPage(int pageNumber) {
    emit(QuranPageLoading(pageNumber: pageNumber));
    try {
      List<Ayah> ayahsOnPage = [];
      // المرور على السور للبحث عن الآيات التي تنتمي لهذه الصفحة
      for (int i = 1; i <= 114; i++) {
        final surah = _quranService.getSurah(i);
        final versesOnPage = surah.verses
            .where((v) => v.page == pageNumber)
            .toList();
        if (versesOnPage.isNotEmpty) {
          ayahsOnPage.addAll(versesOnPage);
        }
      }

      if (ayahsOnPage.isNotEmpty) {
        if (_allSurahs.isEmpty) {
          _allSurahs = _quranService.getAllSurahs();
        }
        emit(
          QuranPageSuccess(
            ayahs: ayahsOnPage,
            pageNumber: pageNumber,
            allSurahs: _allSurahs,
            isPlaying: _isPlaying, // مزامنة حالة زر التشغيل
          ),
        );
      } else {
        emit(QuranPageFailure(message: "لم يتم العثور على آيات في هذه الصفحة"));
      }
    } catch (e) {
      emit(QuranPageFailure(message: e.toString()));
    }
  }

  // بناء رابط الصوت الخاص بالآية لقارئ معين
  String getAudioUrl(int surah, int ayah) {
    return _quranService.getAudioUrl(
      surah,
      ayah,
      reciterIdentifier: Reciters.abdulBasit, // TODO : change reciter
    );
  }

  void startPlaySpecifcAyah({
    required String url,
    required VoidCallback onComplete,
  }) {
    _audioPlayer.play(UrlSource(url));
    _audioPlayer.onPlayerComplete.first.then((_) {
      onComplete();
    });
  }

  // بدء تشغيل الصوت لآية محددة
  void startPlaying({required int surah, required int ayah}) {
    _currentSurahNum = surah;

    // البحث عن الترتيب النسبي للآية داخل السورة (Index)
    final sData = _quranService.getSurah(surah);
    final index = sData.verses.indexWhere((v) => v.id == ayah);
    _currentAyahNum = (index != -1) ? index + 1 : 1;

    // الحصول على بيانات الآية الحالية لمعرفة رقم صفحتها
    final currentAyah = sData.verses[_currentAyahNum! - 1];
    _isPlaying = true;

    // إرسال تنبيه للواجهة لتحديث التظليل والصفحة
    if (onAyahChanged != null) {
      onAyahChanged!(surah, ayah, currentAyah.page);
    }

    // جلب الرابط وتشغيله
    final url = getAudioUrl(surah, _currentAyahNum!);
    loadAudio(url);

    // تحديث الحالة فوراً لتغيير أيقونة الزر
    if (state is QuranPageSuccess) {
      emit((state as QuranPageSuccess).copyWith(isPlaying: true));
    }
  }

  // إيقاف التشغيل وتصفير بيانات التتبع
  void stopPlaying() {
    _audioPlayer.stop();
    _currentSurahNum = null;
    _currentAyahNum = null;
    _isPlaying = false;

    // تحديث الحالة فوراً لإرجاع أيقونة التشغيل
    if (state is QuranPageSuccess) {
      emit((state as QuranPageSuccess).copyWith(isPlaying: false));
    }
  }

  // منطق الانتقال للآية التالية تلقائياً
  void playNextAyah() {
    if (_currentSurahNum == null || _currentAyahNum == null) return;

    final surahData = _quranService.getSurah(_currentSurahNum!);

    // الانتقال للآية التالية في نفس السورة
    if (_currentAyahNum! < surahData.verses.length) {
      _currentAyahNum = _currentAyahNum! + 1;
    }
    // الانتقال لأول آية في السورة التالية
    else if (_currentSurahNum! < 114) {
      _currentSurahNum = _currentSurahNum! + 1;
      _currentAyahNum = 1;
    }
    // التوقف النهائي عند نهاية المصحف
    else {
      stopPlaying();
      return;
    }

    // جلب بيانات الآية الجديدة لإرسالها للواجهة
    final nextVerse = _quranService
        .getSurah(_currentSurahNum!)
        .verses[_currentAyahNum! - 1];

    if (onAyahChanged != null) {
      onAyahChanged!(_currentSurahNum!, nextVerse.id, nextVerse.page);
    }

    final url = getAudioUrl(_currentSurahNum!, _currentAyahNum!);
    loadAudio(url);

    // الحفاظ على حالة التشغيل نشطة في الـ UI
    if (state is QuranPageSuccess) {
      emit((state as QuranPageSuccess).copyWith(isPlaying: true));
    }
  }

  // تمرير الرابط للمشغل الفعلي مع دعم التخزين المؤقت (Caching)
  Future<void> loadAudio(String url) async {
    try {
      // نطلب من مدير التخزين جلب الملف؛ إذا كان موجوداً سيعيده فوراً
      // وإذا لم يكن موجوداً سيقوم بتحميله وحفظه للمرة القادمة تلقائياً
      final file = await DefaultCacheManager().getSingleFile(url);

      // التشغيل من مسار الملف المحلي (أسرع ويوفر باقة الإنترنت)
      await _audioPlayer.play(DeviceFileSource(file.path));
    } catch (e) {
      // في حالة حدوث خطأ (مثل عدم وجود إنترنت والملف ليس مخزناً سابقاً)
      // نحاول التشغيل المباشر من الرابط كحل أخير
      await _audioPlayer.play(UrlSource(url));
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose(); // إغلاق مشغل الصوت نهائياً عند تدمير الـ Cubit
    return super.close();
  }

  // تحميل قائمة السور الأساسية
  void loadSurahs() {
    try {
      _allSurahs = _quranService.getAllSurahs();
      emit(
        QuranSuccess(
          allSurahs: _allSurahs,
          filteredSurahs: _allSurahs,
          filteredAyahs: [],
        ),
      );
    } catch (e) {
      emit(QuranFailure(message: e.toString()));
    }
  }

  // منطق البحث والفلترة للسور والآيات
  void filterSurahs(String query) {
    if (state is QuranSuccess || state is QuranEmpty) {
      if (query.isEmpty) {
        emit(
          QuranSuccess(
            allSurahs: _allSurahs,
            filteredSurahs: _allSurahs,
            filteredAyahs: [],
          ),
        );
      } else {
        final normalizedQuery = query.toLowerCase().replaceAll(
          RegExp(r'[\s-]'),
          '',
        );

        // البحث في أسماء السور (عربي/إنجليزي) وفي الأرقام
        final matchedSurahs = _allSurahs.where((surah) {
          final normalizedName = surah.nameEn.toLowerCase().replaceAll(
            RegExp(r'[\s-]'),
            '',
          );
          return normalizedName.contains(normalizedQuery) ||
              surah.nameAr.contains(query) ||
              surah.number.toString().contains(query);
        }).toList();

        if (matchedSurahs.isNotEmpty) {
          emit(
            QuranSuccess(
              allSurahs: _allSurahs,
              filteredSurahs: matchedSurahs,
              filteredAyahs: [],
            ),
          );
        } else {
          // إذا لم يجد سورة، يبحث في محتوى الآيات (Full Text Search)
          final matchedAyahs = _quranService.search(query);
          if (matchedAyahs.isEmpty) {
            emit(QuranEmpty());
          } else {
            emit(
              QuranSuccess(
                allSurahs: _allSurahs,
                filteredSurahs: [],
                filteredAyahs: matchedAyahs,
              ),
            );
          }
        }
      }
    }
  }
}
