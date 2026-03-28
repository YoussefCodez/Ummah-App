import 'package:json_annotation/json_annotation.dart';
import 'data_model.dart';

part 'timing_model.g.dart';

@JsonSerializable()
class TimingModel {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "data")
  final List<Data>? data;

  TimingModel({this.code, this.status, this.data});

  factory TimingModel.fromJson(Map<String, dynamic> json) =>
      _$TimingModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimingModelToJson(this);
}
