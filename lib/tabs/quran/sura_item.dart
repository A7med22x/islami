import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/quran/sura.dart';
import 'package:islami/utils/arabic_utils.dart';

class SuraItem extends StatelessWidget {
  final Sura sura;

  const SuraItem({super.key, required this.sura});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          width: 40,
          height: 40,
          alignment: .center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sura_number.png'),
            ),
          ),
          child: Text(
            '${sura.suraNumber}',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: sura.suraNumber > 99 ? 10 : 12),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(sura.englishName, style: textTheme.titleMedium),
                  Text(
                    sura.arabicName,
                    style: textTheme.bodyLarge!.copyWith(color: AppTheme.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text('${sura.ayatCount} Verses', style: textTheme.titleSmall),
                  Text(
                    sura.makkia ? "مكية" : "مدنية",
                    style: textTheme.bodyLarge!.copyWith(
                      color: AppTheme.white,
                      fontSize: 20,
                      height: 1,
                    ),
                  ),
                  Text(
                    '${ArabicUtils.numberToArabic(sura.ayatCount)} ${sura.ayatCount < 10 ? "آيات" : "آية"}',
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          ArabicUtils.numberToArabic(sura.suraNumber),
          style: textTheme.bodyLarge!.copyWith(
            color: AppTheme.white,
            fontWeight: .bold,
            height: 1,
          ),
        ),
      ],
    );
  }
}
