import 'package:intl/intl.dart';
import 'package:ummah/features/home/presentation/cubit/salwat_strategy.dart';

class TimingEntity {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String gregorianDate;
  final String gregorianMonth;
  final String gregorianYear;
  final String hijriDate;
  final String hijriMonth;
  final String hijriMonthAr;
  final String hijriYear;
  final String dayEn;
  final String dayAr;
  TimingEntity({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.gregorianDate,
    required this.gregorianMonth,
    required this.gregorianYear,
    required this.hijriDate,
    required this.hijriMonth,
    required this.hijriMonthAr,
    required this.hijriYear,
    required this.dayEn,
    required this.dayAr,
  });

  List<SalwatStrategy> getSalwatStrategies() {
    return [
      Fajr(timeStr: fajr),
      Shrook(timeStr: sunrise),
      Dhuhr(timeStr: dhuhr),
      Asr(timeStr: asr),
      Maghrib(timeStr: maghrib),
      Isha(timeStr: isha),
    ];
  }

  DateTime _getPrayerDateTime(String timeStr) {
    final now = DateTime.now();
    final parts = timeStr.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  String convertTo12Hour(String time24) {
    try {
      final time = DateFormat("HH:mm").parse(time24);
      return DateFormat('h:mm').format(time);
    } catch (e) {
      return time24;
    }
  }

  String convertTo12HourWithPeriod(String time24) {
    try {
      final time = DateFormat("HH:mm").parse(time24);
      return DateFormat('h:mm a').format(time);
    } catch (e) {
      return time24;
    }
  }

  (int, int) getActiveAndNextIndex() {
    final salahTimes = getSalwatStrategies();
    DateTime now = DateTime.now();
    int activeIndex = -1;
    int nextIndex = -1;
    // 2. اللوب دي عشان نحدد "أني صلاة إحنا فيها دلوقتي"
    for (int i = 0; i < salahTimes.length; i++) {
      if (i == salahTimes.length - 1) {
        // حالة صلاة العشاء: لو الوقت بعد العشاء أو قبل الفجر
        if (now.isAfter(_getPrayerDateTime(isha)) ||
            now.isBefore(_getPrayerDateTime(fajr))) {
          activeIndex = i;
          nextIndex = 0;
        }
      } else {
        // أي صلاة تانية: لو الوقت بين الصلاة دي واللي بعدها
        if ((now.isAfter(_getPrayerDateTime(salahTimes[i].timeStr)) ||
                now.isAtSameMomentAs(
                  _getPrayerDateTime(salahTimes[i].timeStr),
                )) &&
            now.isBefore(_getPrayerDateTime(salahTimes[i + 1].timeStr))) {
          activeIndex = i;
          nextIndex = i + 1;
        }
      }
    }
    return (activeIndex, nextIndex);
  }
}
