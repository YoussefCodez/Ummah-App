import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_azkar/islamic_azkar.dart';
import 'package:ummah/core/services/islamic_azkar_service.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/services/hive_service.dart';
import 'package:ummah/features/azkar/presentation/cubit/azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  final _hiveService = getIt<HiveService>();
  int _categoryIndex = 0;

  AzkarCubit() : super(AzkarInitial());

  void loadAzkar(int categoryIndex) {
    _categoryIndex = categoryIndex;
    late final List<Zekr> azkar;
    switch (categoryIndex) {
      case 0:
        azkar = service.getAzkarByCategory(ZekrCategory.morning);
        break;
      case 1:
        azkar = service.getAzkarByCategory(ZekrCategory.evening);
        break;
      case 2:
        azkar = service.getAzkarByCategory(ZekrCategory.wakingUp);
        break;
      case 3:
        azkar = service.getAzkarByCategory(ZekrCategory.wudu);
        break;
      case 4:
        azkar = service.getAzkarByCategory(ZekrCategory.afterPrayer);
        break;
      case 5:
        azkar = service.getAzkarByCategory(ZekrCategory.azan);
        break;
      default:
        azkar = [];
    }

    final savedCounts = _hiveService.getAzkarProgress(categoryIndex);
    final counts = savedCounts != null && savedCounts.length == azkar.length
        ? savedCounts
        : azkar.map((z) => z.repeat).toList();

    emit(AzkarLoaded(azkarList: azkar, currentCounts: counts));
  }

  void decrementZikr(int index) {
    if (state is AzkarLoaded) {
      final currentState = state as AzkarLoaded;
      final currentCounts = List<int>.from(currentState.currentCounts);

      if (currentCounts[index] > 0) {
        currentCounts[index]--;
        emit(currentState.copyWith(currentCounts: currentCounts));
        _hiveService.saveAzkarProgress(_categoryIndex, currentCounts);
      }
    }
  }

  void resetZikr(int index) {
    if (state is AzkarLoaded) {
      final currentState = state as AzkarLoaded;
      final currentCounts = List<int>.from(currentState.currentCounts);

      currentCounts[index] = currentState.azkarList[index].repeat;
      emit(currentState.copyWith(currentCounts: currentCounts));
      _hiveService.saveAzkarProgress(_categoryIndex, currentCounts);
    }
  }

  void resetAll() {
    if (state is AzkarLoaded) {
      final currentState = state as AzkarLoaded;
      final initialCounts = currentState.azkarList
          .map((z) => z.repeat)
          .toList();
      emit(currentState.copyWith(currentCounts: initialCounts));
      _hiveService.saveAzkarProgress(_categoryIndex, initialCounts);
    }
  }
}
