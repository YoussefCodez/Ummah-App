import 'package:injectable/injectable.dart';
import 'package:ummah/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:ummah/features/settings/domain/entities/settings_entity.dart';
import 'package:ummah/features/settings/domain/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  SettingsEntity getSettings() {
    return localDataSource.getSettings();
  }

  @override
  Future<void> saveSettings(SettingsEntity settings) {
    return localDataSource.saveSettings(settings);
  }
}
