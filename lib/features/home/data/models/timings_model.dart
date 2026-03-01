import 'package:json_annotation/json_annotation.dart';

part 'timings_model.g.dart';

@JsonSerializable()
class Timings {
  @JsonKey(name: "Fajr")
  final String? fajr;
  @JsonKey(name: "Sunrise")
  final String? sunrise;
  @JsonKey(name: "Dhuhr")
  final String? dhuhr;
  @JsonKey(name: "Asr")
  final String? asr;
  @JsonKey(name: "Sunset")
  final String? sunset;
  @JsonKey(name: "Maghrib")
  final String? maghrib;
  @JsonKey(name: "Isha")
  final String? isha;
  @JsonKey(name: "Imsak")
  final String? imsak;
  @JsonKey(name: "Midnight")
  final String? midnight;
  @JsonKey(name: "Firstthird")
  final String? firstthird;
  @JsonKey(name: "Lastthird")
  final String? lastthird;

  Timings({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
    this.firstthird,
    this.lastthird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) =>
      _$TimingsFromJson(json);

  Map<String, dynamic> toJson() => _$TimingsToJson(this);
}
