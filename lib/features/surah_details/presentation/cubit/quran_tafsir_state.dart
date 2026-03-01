part of 'quran_tafsir_cubit.dart';

@immutable
sealed class QuranTafsirState {}

final class QuranTafsirInitial extends QuranTafsirState {}


final class QuranTafsirSuccess extends QuranTafsirState {
  final Map<int, String> tafsir;
  QuranTafsirSuccess({required this.tafsir});
}

final class QuranTafsirLoading extends QuranTafsirState {}

final class QuranTafsirFailure extends QuranTafsirState {
  final String message;
  QuranTafsirFailure({required this.message});
}
