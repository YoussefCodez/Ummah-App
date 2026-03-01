import 'package:json_annotation/json_annotation.dart';

part 'designation_model.g.dart';

@JsonSerializable()
class Designation {
  @JsonKey(name: "abbreviated")
  final String? abbreviated;
  @JsonKey(name: "expanded")
  final String? expanded;

  Designation({this.abbreviated, this.expanded});

  factory Designation.fromJson(Map<String, dynamic> json) =>
      _$DesignationFromJson(json);

  Map<String, dynamic> toJson() => _$DesignationToJson(this);
}
