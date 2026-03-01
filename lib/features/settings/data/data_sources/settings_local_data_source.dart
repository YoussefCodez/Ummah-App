import 'package:ummah/features/settings/domain/entities/settings_entity.dart';

abstract class SettingsLocalDataSource {
  SettingsEntity getSettings();
  Future<void> saveSettings(SettingsEntity settings);
}
