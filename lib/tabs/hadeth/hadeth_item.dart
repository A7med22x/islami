import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

class HadethItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenSize = MediaQuery.sizeOf(context).height;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: .circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Image.asset(
                  'assets/images/leftheader.png',
                  height: screenSize * 0.1,
                  fit: .fill,
                  color: AppTheme.black,
                ),
                Text(
                  'data',
                  style: textTheme.headlineSmall!.copyWith(
                    color: AppTheme.black,
                  ),
                ),
                Image.asset(
                  'assets/images/right_header.png',
                  height: screenSize * 0.1,
                  fit: .fill,
                  color: AppTheme.black,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: .infinity,
              height: .infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/hadith_card_background.png'),
                ),
              ),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (_, index) => Text(
                  'data',
                  style: textTheme.titleMedium!.copyWith(color: AppTheme.black),
                  textAlign: .center,
                ),
                separatorBuilder: (_, _) => SizedBox(height: 4),
                itemCount: 50,
              ),
            ),
          ),
          Image.asset(
            'assets/images/footer.png',
            width: .infinity,
            color: AppTheme.black,
          ),
        ],
      ),
    );
  }
}
