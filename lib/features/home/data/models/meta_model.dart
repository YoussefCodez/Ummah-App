import 'package:json_annotation/json_annotation.dart';
import 'method_model.dart';

part 'meta_model.g.dart';

@JsonSerializable()
class Meta {
  @JsonKey(name: "latitude")
  final double? latitude;
  @JsonKey(name: "longitude")
  final double? longitude;
  @JsonKey(name: "timezone")
  final String? timezone;
  @JsonKey(name: "method")
  final Method? method;
  @JsonKey(name: "latitudeAdjustmentMethod")
  final String? latitudeAdjustmentMethod;
  @JsonKey(name: "midnightMode")
  final String? midnightMode;
  @JsonKey(name: "school")
  final String? school;
  @JsonKey(name: "offset")
  final Map<String, int>? offset;

  Meta({
    this.latitude,
    this.longitude,
    this.timezone,
    this.method,
    this.latitudeAdjustmentMethod,
    this.midnightMode,
    this.school,
    this.offset,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
