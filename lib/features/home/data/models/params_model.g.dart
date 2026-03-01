// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Params _$ParamsFromJson(Map<String, dynamic> json) => Params(
  fajr: (json['Fajr'] as num?)?.toDouble(),
  isha: (json['Isha'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ParamsToJson(Params instance) => <String, dynamic>{
  'Fajr': instance.fajr,
  'Isha': instance.isha,
};
