import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/quran/quran_service.dart';
import 'package:islami/tabs/quran/sura.dart';
import 'package:islami/tabs/quran/sura_details_screen.dart';
import 'package:islami/tabs/quran/sura_item.dart';

class QuranTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Suras List',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (_, index) {
              Sura sura = QuranService.suras[index];
              return InkWell(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(SuraDetailsScreen.routeName, arguments: sura);
                },
                child: SuraItem(sura: sura),
              );
            },
            separatorBuilder: (_, _) => Divider(
              color: AppTheme.white,
              indent: screenWidth * .1,
              endIndent: screenWidth * .1,
            ),
            itemCount: QuranService.suras.length,
          ),
        ),
      ],
    );
  }
}
