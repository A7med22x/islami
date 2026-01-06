import 'package:flutter/material.dart';

class SebhaTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: const EdgeInsets.all(26),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'سَبِّحِ اسْمَ رَبِّكَ الأعلى ',
              style: textTheme.displaySmall,
            ),
          ),
          Image.asset('assets/images/sebha_body.png'),
          Container(
            width: .infinity,
            height: screenHeight * .4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sebhabody1.png'),
                fit: .fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Text('سبحان الله', style: textTheme.displaySmall),
                SizedBox(height: 10),
                Text('30', style: textTheme.displaySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
