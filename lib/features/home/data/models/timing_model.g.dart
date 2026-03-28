// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimingModel _$TimingModelFromJson(Map<String, dynamic> json) => TimingModel(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TimingModelToJson(TimingModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
