// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hijri_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hijri _$HijriFromJson(Map<String, dynamic> json) => Hijri(
  date: json['date'] as String?,
  format: json['format'] as String?,
  day: json['day'] as String?,
  weekday: json['weekday'] == null
      ? null
      : HijriWeekday.fromJson(json['weekday'] as Map<String, dynamic>),
  month: json['month'] == null
      ? null
      : HijriMonth.fromJson(json['month'] as Map<String, dynamic>),
  year: json['year'] as String?,
  designation: json['designation'] == null
      ? null
      : Designation.fromJson(json['designation'] as Map<String, dynamic>),
  holidays: json['holidays'] as List<dynamic>?,
  adjustedHolidays: json['adjustedHolidays'] as List<dynamic>?,
  method: json['method'] as String?,
);

Map<String, dynamic> _$HijriToJson(Hijri instance) => <String, dynamic>{
  'date': instance.date,
  'format': instance.format,
  'day': instance.day,
  'weekday': instance.weekday,
  'month': instance.month,
  'year': instance.year,
  'designation': instance.designation,
  'holidays': instance.holidays,
  'adjustedHolidays': instance.adjustedHolidays,
  'method': instance.method,
};
