import 'package:json_annotation/json_annotation.dart';
import 'hijri_model.dart';
import 'greogrian_model.dart';

part 'date_model.g.dart';

@JsonSerializable()
class Date {
  @JsonKey(name: "readable")
  final String? readable;
  @JsonKey(name: "timestamp")
  final String? timestamp;
  @JsonKey(name: "hijri")
  final Hijri? hijri;
  @JsonKey(name: "gregorian")
  final Gregorian? gregorian;

  Date({this.readable, this.timestamp, this.hijri, this.gregorian});

  factory Date.fromJson(Map<String, dynamic> json) => _$DateFromJson(json);

  Map<String, dynamic> toJson() => _$DateToJson(this);

}
