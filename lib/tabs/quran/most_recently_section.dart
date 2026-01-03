import 'package:flutter/material.dart';
import 'package:islami/tabs/quran/most_recently_item.dart';
import 'package:islami/tabs/quran/quran_service.dart';

class MostRecentlySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Visibility(
      visible: QuranService.mostRecently.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text('Most Recently', style: textTheme.titleMedium),
            SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.16,
              child: ListView.separated(
                scrollDirection: .horizontal,
                itemBuilder: (_, index) => MostRecentlyItem(
                  sura: QuranService.mostRecently.reversed.toList()[index],
                ),
                separatorBuilder: (_, _) => SizedBox(width: 10),
                itemCount: QuranService.mostRecently.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
