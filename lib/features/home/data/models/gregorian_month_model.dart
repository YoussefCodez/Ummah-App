import 'package:json_annotation/json_annotation.dart';

part 'gregorian_month_model.g.dart';

@JsonSerializable()
class GregorianMonth {
  @JsonKey(name: "number")
  final int? number;
  @JsonKey(name: "en")
  final String? en;

  GregorianMonth({this.number, this.en});

  factory GregorianMonth.fromJson(Map<String, dynamic> json) =>
      _$GregorianMonthFromJson(json);

  Map<String, dynamic> toJson() => _$GregorianMonthToJson(this);
}
