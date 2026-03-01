import 'package:ummah/features/settings/domain/entities/settings_entity.dart';

abstract class SettingsState {}

class SettingsLoaded extends SettingsState {
  final SettingsEntity settings;
  SettingsLoaded(this.settings);
}
