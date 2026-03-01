// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimingModel _$TimingModelFromJson(Map<String, dynamic> json) => TimingModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TimingModelToJson(TimingModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
