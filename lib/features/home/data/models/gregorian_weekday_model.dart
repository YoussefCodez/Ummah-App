import 'package:json_annotation/json_annotation.dart';

part 'gregorian_weekday_model.g.dart';

@JsonSerializable()
class GregorianWeekday {
  @JsonKey(name: "en")
  final String? en;

  GregorianWeekday({this.en});

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) =>
      _$GregorianWeekdayFromJson(json);

  Map<String, dynamic> toJson() => _$GregorianWeekdayToJson(this);
}
