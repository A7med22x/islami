import 'package:intl/intl.dart';
import 'package:islami/models/prayer_times_response/gregorian.dart';
import 'package:islami/models/prayer_times_response/hijri.dart';

class DataFormatter {
  static String formatGregorian(Gregorian gregorian) {
    return '${gregorian.day} ${gregorian.month!.en!.substring(0, 3)},\n ${gregorian.year}';
  }

  static String formatHijri(Hijri hijri) {
    return '${hijri.day} ${hijri.month!.en!.substring(0, 3)},\n ${hijri.year}';
  }

  static String formatTime(String time) {
    final timeFormat = DateFormat('HH:mm').parse(time);
    return DateFormat('hh:mm a').format(timeFormat);
  }

  static Map<String, dynamic> sortPrayerTimes(
    Map<String, dynamic> prayerTimes,
  ) {
    final now = DateTime.now();
    final sortedEntries = prayerTimes.entries.toList()
      ..sort((a, b) {
        final timeA = DateFormat('HH:mm').parse(a.value);
        final timeB = DateFormat('HH:mm').parse(b.value);

        DateTime dateTimeA = DateTime(
          now.year,
          now.month,
          now.day,
          timeA.hour,
          timeA.minute,
        );
        DateTime dateTimeB = DateTime(
          now.year,
          now.month,
          now.day,
          timeB.hour,
          timeB.minute,
        );

        if (dateTimeA.isBefore(now) || dateTimeA.isAtSameMomentAs(now)) {
          dateTimeA = dateTimeA.add(Duration(days: 1));
        }

        if (dateTimeB.isBefore(now) || dateTimeB.isAtSameMomentAs(now)) {
          dateTimeB = dateTimeB.add(Duration(days: 1));
        }

        return dateTimeA.compareTo(dateTimeB);
      });

    return Map<String, dynamic>.fromEntries(sortedEntries);
  }

  static Map<String, dynamic> getNextPrayer(Map<String, dynamic> prayerTimes) {
    Map<String, dynamic> timeDifference = {};
    prayerTimes.forEach((prayeName, prayerTimeString) {
      final now = DateTime.now();
      DateTime prayerDateTime = DateFormat('HH:mm').parse(prayerTimeString);
      prayerDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        prayerDateTime.hour,
        prayerDateTime.minute,
      );

      if (prayerDateTime.isBefore(now) ||
          prayerDateTime.isAtSameMomentAs(now)) {
        prayerDateTime = prayerDateTime.add(Duration(days: 1));
      }

      Duration difference = prayerDateTime.difference(now);
      timeDifference[prayeName] = difference;
    });
    return timeDifference;
  }
}
