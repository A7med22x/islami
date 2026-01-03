import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/quran/sura.dart';
import 'package:islami/tabs/quran/sura_details_screen.dart';

class MostRecentlyItem extends StatelessWidget {
  Sura sura;

  MostRecentlyItem({required this.sura});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(SuraDetailsScreen.routeName, arguments: sura);
      },
      child: Container(
        height: .infinity,
        width: screenSize.width * 0.7,
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              mainAxisAlignment: .spaceEvenly,
              children: [
                Text(
                  sura.englishName,
                  style: textTheme.headlineSmall!.copyWith(
                    color: AppTheme.black,
                  ),
                ),
                Text(
                  sura.arabicName,
                  style: textTheme.headlineSmall!.copyWith(
                    color: AppTheme.black,
                  ),
                ),
                Text(
                  '${sura.ayatCount} Verses',
                  style: textTheme.titleSmall!.copyWith(color: AppTheme.black),
                ),
              ],
            ),
            Image.asset(
              'assets/images/most_recent.png',
              width: screenSize.width * 0.3,
              height: screenSize.height * 0.14,
              fit: .fill,
            ),
          ],
        ),
      ),
    );
  }
}
