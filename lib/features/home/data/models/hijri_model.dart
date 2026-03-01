import 'package:json_annotation/json_annotation.dart';
import 'hijri_weekday_model.dart';
import 'hijri_month_model.dart';
import 'designation_model.dart';

part 'hijri_model.g.dart';

@JsonSerializable()
class Hijri {
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "format")
  final String? format;
  @JsonKey(name: "day")
  final String? day;
  @JsonKey(name: "weekday")
  final HijriWeekday? weekday;
  @JsonKey(name: "month")
  final HijriMonth? month;
  @JsonKey(name: "year")
  final String? year;
  @JsonKey(name: "designation")
  final Designation? designation;
  @JsonKey(name: "holidays")
  final List<dynamic>? holidays;
  @JsonKey(name: "adjustedHolidays")
  final List<dynamic>? adjustedHolidays;
  @JsonKey(name: "method")
  final String? method;

  Hijri({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
    this.holidays,
    this.adjustedHolidays,
    this.method,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) => _$HijriFromJson(json);

  Map<String, dynamic> toJson() => _$HijriToJson(this);
}
