import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/quran/sura_details_screen.dart';

class MostRecentlyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(SuraDetailsScreen.routeName);
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
                  'Most Recently',
                  style: textTheme.headlineSmall!.copyWith(
                    color: AppTheme.black,
                  ),
                ),
                Text(
                  'Most Recently',
                  style: textTheme.headlineSmall!.copyWith(
                    color: AppTheme.black,
                  ),
                ),
                Text(
                  'Most Recently',
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
