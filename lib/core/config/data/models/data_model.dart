import 'package:json_annotation/json_annotation.dart';
import 'timings_model.dart';
import 'date_model.dart';
import 'meta_model.dart';
import 'package:ummah/core/config/domain/entities/timing_entity.dart';

part 'data_model.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: "statuscode")
  final int? statusCode;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "timings")
  final Timings? timings;
  @JsonKey(name: "date")
  final Date? date;
  @JsonKey(name: "meta")
  final Meta? meta;

  Data({this.statusCode, this.message, this.timings, this.date, this.meta});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  TimingEntity toEntity() {
    String clean(String? time) =>
        time?.replaceAll(RegExp(r'\s*\(.*\)'), '').trim() ?? '';
    return TimingEntity(
      fajr: clean(timings?.fajr),
      sunrise: clean(timings?.sunrise),
      dhuhr: clean(timings?.dhuhr),
      asr: clean(timings?.asr),
      maghrib: clean(timings?.maghrib),
      isha: clean(timings?.isha),
      weekDayEn: date?.gregorian?.weekday?.en ?? '',
      weekDayAr: date?.hijri?.weekday?.ar ?? '',
      gregorianDate: date?.readable ?? '',
      gregorianMonth: date?.gregorian?.month?.en ?? '',
      gregorianYear: date?.gregorian?.year ?? '',
      hijriDate:
          '${date?.hijri?.day} ${date?.hijri?.month?.ar} ${date?.hijri?.year}',
      hijriMonth: date?.hijri?.month?.en ?? '',
      hijriMonthAr: date?.hijri?.month?.ar ?? '',
      hijriYear: date?.hijri?.year ?? '',
      dayEn: date?.gregorian?.weekday?.en ?? '',
      dayAr: date?.hijri?.weekday?.ar ?? '',
    );
  }
}
