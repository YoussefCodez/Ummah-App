import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/services/hive_service.dart';
import 'package:ummah/features/quran/domain/entities/saved_page_entity.dart';

part 'saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  final hiveService = getIt<HiveService>();
  Map<int, SavedPageEntity> savedPages = {};

  SavedCubit() : super(SavedInitial()) {
    _loadSavedPages();
  }

  void toggleSave(int pageNumber, int juzNumber, String surahName, String surahNameEn) {
    emit(SavedLoading());
    try {
      if (savedPages.containsKey(pageNumber)) {
        savedPages.remove(pageNumber);
      } else {
        savedPages[pageNumber] = SavedPageEntity(
          surahName: surahName,
          surahNameEn: surahNameEn,
          juzNumber: juzNumber,
          pageNumber: pageNumber,
        );
      }

      final dataToSave = savedPages.map(
        (key, value) => MapEntry(key, value.toJson()),
      );
      hiveService.saveSavedPages(dataToSave);

      emit(SavedSuccess(savedPages: Map.from(savedPages)));
    } catch (e) {
      emit(SavedFailure(e.toString()));
    }
  }

  void _loadSavedPages() {
    try {
      final cached = hiveService.getSavedPages();
      if (cached != null) {
        savedPages = cached.map((key, value) {
          return MapEntry(
            key as int,
            SavedPageEntity.fromJson(Map<String, dynamic>.from(value)),
          );
        });
      }
      emit(SavedSuccess(savedPages: Map.from(savedPages)));
    } catch (e) {
      emit(SavedFailure(e.toString()));
    }
  }
}
