import 'package:json_annotation/json_annotation.dart';
import 'data_model.dart';
import 'package:ummah/features/home/domain/entities/timing_entity.dart';

part 'timing_model.g.dart';

@JsonSerializable()
class TimingModel {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "data")
  final Data? data;

  TimingModel({this.code, this.status, this.data});

  factory TimingModel.fromJson(Map<String, dynamic> json) =>
      _$TimingModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimingModelToJson(this);

  TimingEntity toEntity() => data?.toEntity() ?? TimingEntity(
    fajr: '',
    sunrise: '',
    dhuhr: '',
    asr: '',
    maghrib: '',
    isha: '',
    gregorianDate: '',
    gregorianMonth: '',
    gregorianYear: '',
    hijriDate: '',
    hijriMonth: '',
    hijriMonthAr: '',
    hijriYear: '',
    dayEn: '',
    dayAr: '',
  );
}
