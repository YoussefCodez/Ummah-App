import 'package:ummah/features/home/domain/entities/timing_entity.dart';

extension TimingDateTime on TimingEntity {
  DateTime _parseTime(String time) {
    final now = DateTime.now();
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
  }

  DateTime get fajrDateTime => _parseTime(fajr);
  DateTime get sunriseDateTime => _parseTime(sunrise);
  DateTime get dhuhrDateTime => _parseTime(dhuhr);
  DateTime get asrDateTime => _parseTime(asr);
  DateTime get maghribDateTime => _parseTime(maghrib);
  DateTime get ishaDateTime => _parseTime(isha);
}