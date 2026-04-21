import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/models/prayer_times_response/gregorian.dart';
import 'package:islami/models/prayer_times_response/hijri.dart';
import 'package:islami/utils/data_formatter.dart';

class PrayerDateHeader extends StatelessWidget {
  const PrayerDateHeader({
    super.key,
    required this.gregorianDate,
    required this.hijriDate,
    required this.day,
  });

  final Gregorian gregorianDate;
  final Hijri hijriDate;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          DataFormatter.formatGregorian(gregorianDate),
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 2,
        ),
        Column(
          children: [
            AutoSizeText(
              'Pray Time',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppTheme.black.withValues(alpha: 0.7),
              ),
              maxLines: 1,
            ),
            AutoSizeText(
              day,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppTheme.black.withValues(alpha: 0.9),
              ),
              maxLines: 1,
            ),
          ],
        ),
        AutoSizeText(
          DataFormatter.formatHijri(hijriDate),
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 2,
        ),
      ],
    );
  }
}
