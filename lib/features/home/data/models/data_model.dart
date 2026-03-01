import 'package:json_annotation/json_annotation.dart';
import 'timings_model.dart';
import 'date_model.dart';
import 'meta_model.dart';
import 'package:ummah/features/home/domain/entities/timing_entity.dart';

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
    return TimingEntity(
      fajr: timings?.fajr ?? '',
      sunrise: timings?.sunrise ?? '',
      dhuhr: timings?.dhuhr ?? '',
      asr: timings?.asr ?? '',
      maghrib: timings?.maghrib ?? '',
      isha: timings?.isha ?? '',
      gregorianDate: date?.readable ?? '',
      gregorianMonth: date?.gregorian?.month.toString() ?? '',
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
