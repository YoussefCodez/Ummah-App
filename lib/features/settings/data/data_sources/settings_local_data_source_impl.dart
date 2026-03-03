import 'package:injectable/injectable.dart';
import 'package:quran_with_tafsir/models/reciters.dart';
import 'package:ummah/core/services/hive_service.dart';
import 'package:ummah/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:ummah/features/settings/domain/entities/settings_entity.dart';

@LazySingleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final HiveService hiveService;

  SettingsLocalDataSourceImpl(this.hiveService);

  @override
  SettingsEntity getSettings() {
    final textFontSize =
        hiveService.getSetting<double>('textFontSize', defaultValue: 24.0) ??
        24.0;
    final isTextBold =
        hiveService.getSetting<bool>('isTextBold', defaultValue: false) ??
        false;
    final mushafMode =
        hiveService.getSetting<String>('mushafMode', defaultValue: 'mushaf') ??
        'mushaf';
    final reciter =
        hiveService.getSetting<String>(
          'reciter',
          defaultValue: Reciters.abdulBasit,
        ) ??
        Reciters.abdulBasit;

    return SettingsEntity(
      textFontSize: textFontSize,
      isTextBold: isTextBold,
      mushafMode: mushafMode,
      reciter: reciter,
    );
  }

  @override
  Future<void> saveSettings(SettingsEntity settings) async {
    await hiveService.saveSetting<double>(
      'textFontSize',
      settings.textFontSize,
    );
    await hiveService.saveSetting<bool>('isTextBold', settings.isTextBold);
    await hiveService.saveSetting<String>('mushafMode', settings.mushafMode);
    await hiveService.saveSetting<String>('reciter', settings.reciter);
  }
}
