import 'package:json_annotation/json_annotation.dart';

part 'params_model.g.dart';

@JsonSerializable()
class Params {
  @JsonKey(name: "Fajr")
  final double? fajr;
  @JsonKey(name: "Isha")
  final double? isha;

  Params({this.fajr, this.isha});

  factory Params.fromJson(Map<String, dynamic> json) => _$ParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ParamsToJson(this);
}
