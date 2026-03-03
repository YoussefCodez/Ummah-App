import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ummah/features/settings/domain/entities/settings_entity.dart';
import 'package:ummah/features/settings/domain/repositories/settings_repository.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository repository;

  SettingsCubit(this.repository)
    : super(SettingsLoaded(repository.getSettings()));

  void loadSettings() {
    emit(SettingsLoaded(repository.getSettings()));
  }

  void changeTextFontSize(double size) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newSettings = currentState.settings.copyWith(textFontSize: size);
      _updateAndSave(newSettings);
    }
  }

  void changeTextBold(bool isBold) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newSettings = currentState.settings.copyWith(isTextBold: isBold);
      _updateAndSave(newSettings);
    }
  }

  void changeMushafMode(bool isMushafMode) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newSettings = currentState.settings.copyWith(
        mushafMode: isMushafMode ? 'mushaf' : 'ayah',
      );
      _updateAndSave(newSettings);
    }
  }

  void _updateAndSave(SettingsEntity newSettings) {
    emit(SettingsLoaded(newSettings));
    repository.saveSettings(newSettings);
  }

  void changeReciter(String reciter) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      final newSettings = currentState.settings.copyWith(reciter: reciter);
      _updateAndSave(newSettings);
    }
  }
}
