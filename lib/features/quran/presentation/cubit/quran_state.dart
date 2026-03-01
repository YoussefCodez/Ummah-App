part of 'quran_cubit.dart';

@immutable
sealed class QuranState {}

// الحالة الابتدائية عند فتح التطبيق
final class QuranInitial extends QuranState {}

// حالة تحميل البيانات (عرض مؤشر التحميل)
final class QuranLoading extends QuranState {}

// حالة نجاح جلب قائمة السور والفلترة
final class QuranSuccess extends QuranState {
  final List<SurahMetadata> allSurahs;
  final List<SurahMetadata> filteredSurahs;
  final List<Ayah> filteredAyahs;

  QuranSuccess({
    required this.allSurahs,
    required this.filteredSurahs,
    required this.filteredAyahs,
  });
}

// حالة البحث عندما لا توجد نتائج
final class QuranEmpty extends QuranState {}

// حالة حدوث خطأ عام في Cubit القرآن
final class QuranFailure extends QuranState {
  final String message;
  QuranFailure({required this.message});
}

// حالة بدء تحميل بيانات سورة محددة
final class QuranSurahLoading extends QuranState {}

// حالة نجاح جلب بيانات سورة كاملة بآياتها
final class QuranSurahSuccess extends QuranState {
  final Surah surah;
  QuranSurahSuccess({required this.surah});
}

// حالة فشل جلب سورة محددة
final class QuranSurahFailure extends QuranState {
  final String message;
  QuranSurahFailure({required this.message});
}

// حالة بدء تحميل صفحة معينة من المصحف
final class QuranPageLoading extends QuranState {
  final int pageNumber;
  QuranPageLoading({required this.pageNumber});
}

// حالة نجاح عرض صفحة المصحف وتتضمن بيانات المشغل الصوتي
final class QuranPageSuccess extends QuranState {
  final List<Ayah> ayahs; // الآيات الموجودة في هذه الصفحة
  final int pageNumber; // رقم الصفحة الحالية
  final List<SurahMetadata> allSurahs; // مرجع لجميع السور لعرض الأرقام والأسماء
  final bool isPlaying; // هل يوجد صوت يعمل حالياً؟ (لتحديث زر التشغيل)

  QuranPageSuccess({
    required this.ayahs,
    required this.pageNumber,
    required this.allSurahs,
    this.isPlaying = false,
  });

  // دالة لتحديث الحالة جزئياً (مثلاً تحديث حالة التشغيل فقط دون إعادة بناء كل الصفحة)
  QuranPageSuccess copyWith({
    List<Ayah>? ayahs,
    int? pageNumber,
    List<SurahMetadata>? allSurahs,
    bool? isPlaying,
  }) {
    return QuranPageSuccess(
      ayahs: ayahs ?? this.ayahs,
      pageNumber: pageNumber ?? this.pageNumber,
      allSurahs: allSurahs ?? this.allSurahs,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

// حالة فشل تحميل صفحة المصحف
final class QuranPageFailure extends QuranState {
  final String message;
  QuranPageFailure({required this.message});
}
