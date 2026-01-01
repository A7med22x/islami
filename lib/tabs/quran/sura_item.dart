import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

class SuraItem extends StatelessWidget {
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
          child: Text('1', style: textTheme.titleLarge),
        ),

        Column(
          crossAxisAlignment: .start,
          children: [
            Text('Al-Fatiha', style: textTheme.titleLarge),
            Text('7 Verses', style: textTheme.titleSmall),
          ],
        ),
        Spacer(),
        Text('الفاتحه', style: textTheme.titleLarge),
      ],
    );
  }
}
