import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/time/azkar_details_screen.dart';

import '../../models/azkar_model/azkar.dart';

class AzkarSection extends StatelessWidget {
  const AzkarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Text('Azkar', style: Theme.of(context).textTheme.titleLarge),
        ),
        SizedBox(
          height: 220,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => Container(
              height: 220,
              width: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppTheme.black,
                border: Border.all(color: AppTheme.primary, width: 2),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(
          context,
        ).pushNamed(AzkarDetailsScreen.routeName, arguments: Azkar.types[index].name);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(Azkar.types[index].imagePath, height: 150),
                    AutoSizeText(
                      Azkar.types[index].name,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: Azkar.types.length,
          ),
        ),
      ],
    );
  }
}
