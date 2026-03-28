// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  statusCode: (json['statuscode'] as num?)?.toInt(),
  message: json['message'] as String?,
  timings: json['timings'] == null
      ? null
      : Timings.fromJson(json['timings'] as Map<String, dynamic>),
  date: json['date'] == null
      ? null
      : Date.fromJson(json['date'] as Map<String, dynamic>),
  meta: json['meta'] == null
      ? null
      : Meta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'statuscode': instance.statusCode,
  'message': instance.message,
  'timings': instance.timings,
  'date': instance.date,
  'meta': instance.meta,
};
