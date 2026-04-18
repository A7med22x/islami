import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

class PrayerItem extends StatelessWidget {
  const PrayerItem({
    super.key,
    required this.name,
    required this.time,
    required this.pmOrAm,
  });

  final String name;
  final String time;
  final String pmOrAm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.black, AppTheme.brown],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              name,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
            ),
            AutoSizeText(
              time,
              style: Theme.of(context).textTheme.headlineLarge,
              maxLines: 1,
            ),
            AutoSizeText(
              pmOrAm,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
