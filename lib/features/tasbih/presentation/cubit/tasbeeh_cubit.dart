import 'package:bloc/bloc.dart';

class TasbeehState {
  final int currentCount;
  final int zikrIndex;
  final List<String> zikrsAr;
  final List<String> zikrsEn;
  final List<int> targetCounts;

  TasbeehState({
    required this.currentCount,
    required this.zikrIndex,
    required this.zikrsAr,
    required this.zikrsEn,
    required this.targetCounts,
  });

  String get currentZikrAr => zikrsAr[zikrIndex];
  String get currentZikrEn => zikrsEn[zikrIndex];
  int get currentTarget => targetCounts[zikrIndex];
  double get progress => currentCount / currentTarget;

  TasbeehState copyWith({int? currentCount, int? zikrIndex}) {
    return TasbeehState(
      currentCount: currentCount ?? this.currentCount,
      zikrIndex: zikrIndex ?? this.zikrIndex,
      zikrsAr: zikrsAr,
      zikrsEn: zikrsEn,
      targetCounts: targetCounts,
    );
  }
}

class TasbeehCubit extends Cubit<TasbeehState> {
  TasbeehCubit()
    : super(
        TasbeehState(
          currentCount: 0,
          zikrIndex: 0,
          zikrsAr: const [
            'سُبْحَانَ اللَّهِ',
            'الْحَمْدُ لِلَّهِ',
            'اللَّهُ أَكْبَرُ',
            'لا إله إلا الله وحده لا شريك له له الملك وله الحمد وهو على كل شيء قدير',
            'سبحان الله وبحمده سبحان الله العظيم',
            'سبحان الله وبحمده',
          ],
          zikrsEn: const [
            'Subhan Allah',
            'Alhamdulillah',
            'Allahu Akbar',
            'La ilaha illa Allah wahdahu la sharika lah',
            'Subhan Allah wa bihamdihi subhan Allah al-azim',
            'Subhan Allah wa bihamdihi',
          ],
          targetCounts: const [33, 33, 33, 1, 1, 100],
        ),
      );

  void increment() {
    int nextCount = state.currentCount + 1;
    if (nextCount >= state.currentTarget) {
      int nextIndex = (state.zikrIndex + 1) % state.zikrsAr.length;
      emit(state.copyWith(currentCount: 0, zikrIndex: nextIndex));
    } else {
      emit(state.copyWith(currentCount: nextCount));
    }
  }

  void reset() {
    emit(state.copyWith(currentCount: 0, zikrIndex: 0));
  }
}
