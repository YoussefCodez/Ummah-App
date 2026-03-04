import 'package:ummah/core/constants/app_strings.dart';

abstract class SalwatStrategy {
  String timeStr;
  String get name;
  String get svg;
  SalwatStrategy({required this.timeStr});
}

class Fajr extends SalwatStrategy {
  @override
  String get name => AppStrings.fajrEn;
  @override
  String get svg => 'assets/svgs/fajr.svg';
  Fajr({required super.timeStr});
}

class Shrook extends SalwatStrategy {
  @override
  String get name => AppStrings.sunriseEn;
  @override
  String get svg => 'assets/svgs/sunrise.svg';
  Shrook({required super.timeStr});
}

class Dhuhr extends SalwatStrategy {
  @override
  String get name => AppStrings.dhuhrEn;
  @override
  String get svg => 'assets/svgs/sun.svg';
  Dhuhr({required super.timeStr});
}

class Asr extends SalwatStrategy {
  @override
  String get name => AppStrings.asrEn;
  @override
  String get svg => 'assets/svgs/asr.svg';
  Asr({required super.timeStr});
}

class Maghrib extends SalwatStrategy {
  @override
  String get name => AppStrings.maghribEn;
  @override
  String get svg => 'assets/svgs/maghreeb.svg';
  Maghrib({required super.timeStr});
}

class Isha extends SalwatStrategy {
  @override
  String get name => AppStrings.ishaEn;
  @override
  String get svg => 'assets/svgs/isah.svg';
  Isha({required super.timeStr});
}
