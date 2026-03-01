import 'package:ummah/features/settings/domain/entities/settings_entity.dart';

abstract class SettingsRepository {
  SettingsEntity getSettings();
  Future<void> saveSettings(SettingsEntity settings);
}
