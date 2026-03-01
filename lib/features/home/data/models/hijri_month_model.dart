import 'package:json_annotation/json_annotation.dart';

part 'hijri_month_model.g.dart';

@JsonSerializable()
class HijriMonth {
  @JsonKey(name: "number")
  final int? number;
  @JsonKey(name: "en")
  final String? en;
  @JsonKey(name: "ar")
  final String? ar;
  @JsonKey(name: "days")
  final int? days;

  HijriMonth({this.number, this.en, this.ar, this.days});

  factory HijriMonth.fromJson(Map<String, dynamic> json) =>
      _$HijriMonthFromJson(json);

  Map<String, dynamic> toJson() => _$HijriMonthToJson(this);
}
