import 'package:flutter/material.dart';
import 'package:islami/tabs/quran/sura.dart';

class SuraItem extends StatelessWidget {
  final Sura sura;

  const SuraItem({super.key, required this.sura});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 24),
          width: 52,
          height: 52,
          alignment: .center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sura_number.png'),
            ),
          ),
          child: Text('${sura.suraNumber}', style: textTheme.titleSmall),
        ),

        Column(
          crossAxisAlignment: .start,
          children: [
            Text(sura.englishName, style: textTheme.titleLarge),
            Text('${sura.ayatCount} Verses', style: textTheme.titleSmall),
          ],
        ),
        Spacer(),
        Text(sura.arabicName, style: textTheme.titleLarge),
      ],
    );
  }
}
