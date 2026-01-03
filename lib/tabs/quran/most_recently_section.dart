import 'package:flutter/material.dart';
import 'package:islami/tabs/quran/most_recently_item.dart';

class MostRecentlySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Column(
        children: [
          Text('Most Recently', style: textTheme.titleMedium),
          SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.16,
            child: ListView.separated(
              scrollDirection: .horizontal,
              itemBuilder: (_, index) => MostRecentlyItem(),
              separatorBuilder: (_, _) => SizedBox(width: 10),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
