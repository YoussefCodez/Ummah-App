import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:quran_with_tafsir/quran_with_tafsir.dart';

part 'quran_tafsir_state.dart';

@injectable
class QuranTafsirCubit extends Cubit<QuranTafsirState> {
  final QuranService _quranService;
  QuranTafsirCubit(this._quranService) : super(QuranTafsirInitial());
  void loadTafsir(int surahNumber) {
    try {
      emit(QuranTafsirLoading());
      final tafsir = _quranService.getTafsir(surahNumber);
      emit(QuranTafsirSuccess(tafsir: tafsir));
    } catch (e) {
      emit(QuranTafsirFailure(message: e.toString()));
    }
  }
}
