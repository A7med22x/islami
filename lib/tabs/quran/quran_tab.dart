import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/quran/most_recently_section.dart';
import 'package:islami/tabs/quran/quran_service.dart';
import 'package:islami/tabs/quran/sura.dart';
import 'package:islami/tabs/quran/sura_details_screen.dart';
import 'package:islami/tabs/quran/sura_item.dart';

class QuranTab extends StatefulWidget {
  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            style: textTheme.titleMedium,
            decoration: InputDecoration(
              hintText: 'Sura Name',
              prefixIcon: SvgPicture.asset(
                'assets/icons/quran.svg',
                colorFilter: ColorFilter.mode(
                  AppTheme.primary,
                  BlendMode.srcIn,
                ),
                width: 28,
                height: 28,
                fit: .scaleDown,
              ),
            ),
            onChanged: (query) {
              QuranService.searchSura(query);
              setState(() {});
            },
          ),
        ),
        MostRecentlySection(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text('Suras List', style: textTheme.titleMedium),
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
