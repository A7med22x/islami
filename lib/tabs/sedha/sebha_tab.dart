import 'package:flutter/material.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  List<String> tasbeah = ['سبحان الله', 'لا إله إلا الله', 'أستغفر الله'];
  int counter = 1;
  int index = 0;
  double angel = 0.0;

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
          InkWell(
            onTap: onIncreaseCounter,
            child: Stack(
              children: [
                Transform.rotate(
                  angle: angel,
                  child: Image.asset('assets/images/sebhabody1.png'),
                ),
                Center(
                  child: SizedBox(
                    height: screenHeight * .4,
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Text(tasbeah[index], style: textTheme.displaySmall),
                        SizedBox(height: 10),
                        Text('$counter', style: textTheme.displaySmall),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onIncreaseCounter() {
    counter++;
    angel++;
    if (counter % 33 == 0) {
      index++;
      angel = 0;
      if (index >= tasbeah.length) {
        index = 0;
      }
    }
    setState(() {});
  }
}
