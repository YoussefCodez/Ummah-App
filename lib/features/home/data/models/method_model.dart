import 'package:json_annotation/json_annotation.dart';
import 'params_model.dart';
import 'location_model.dart';

part 'method_model.g.dart';

@JsonSerializable()
class Method {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "params")
  final Params? params;
  @JsonKey(name: "location")
  final Location? location;

  Method({this.id, this.name, this.params, this.location});

  factory Method.fromJson(Map<String, dynamic> json) => _$MethodFromJson(json);

  Map<String, dynamic> toJson() => _$MethodToJson(this);
}
