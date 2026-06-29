import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/quran/sura.dart';
import 'package:islami/tabs/quran/sura_details_screen.dart';

class MostRecentlyItem extends StatelessWidget {
  final Sura sura;

  const MostRecentlyItem({super.key, required this.sura});

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
        padding: EdgeInsets.all(8),
        height: .infinity,
        width: screenSize.width * 0.75,
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              mainAxisAlignment: .spaceEvenly,
              crossAxisAlignment: .start,
              children: [
                Text(
                  sura.arabicName,
                  style: textTheme.bodyLarge!.copyWith(
                    color: AppTheme.black,
                    height: 1
                  ),
                ),
                Text(
                  sura.englishName,
                  style: textTheme.headlineSmall!.copyWith(
                    color: AppTheme.black,
                    fontSize: 20
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
