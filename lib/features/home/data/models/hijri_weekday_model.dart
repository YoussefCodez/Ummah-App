import 'package:json_annotation/json_annotation.dart';

part 'hijri_weekday_model.g.dart';

@JsonSerializable()
class HijriWeekday {
  @JsonKey(name: "en")
  final String? en;
  @JsonKey(name: "ar")
  final String? ar;

  HijriWeekday({this.en, this.ar});

  factory HijriWeekday.fromJson(Map<String, dynamic> json) =>
      _$HijriWeekdayFromJson(json);

  Map<String, dynamic> toJson() => _$HijriWeekdayToJson(this);
}
