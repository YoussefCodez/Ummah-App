import 'package:json_annotation/json_annotation.dart';
import 'gregorian_weekday_model.dart';
import 'gregorian_month_model.dart';
import 'designation_model.dart';

part 'greogrian_model.g.dart';

@JsonSerializable()
class Gregorian {
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "format")
  final String? format;
  @JsonKey(name: "day")
  final String? day;
  @JsonKey(name: "weekday")
  final GregorianWeekday? weekday;
  @JsonKey(name: "month")
  final GregorianMonth? month;
  @JsonKey(name: "year")
  final String? year;
  @JsonKey(name: "designation")
  final Designation? designation;
  @JsonKey(name: "lunarSighting")
  final bool? lunarSighting;

  Gregorian({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
    this.lunarSighting,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) =>
      _$GregorianFromJson(json);

  Map<String, dynamic> toJson() => _$GregorianToJson(this);
}
