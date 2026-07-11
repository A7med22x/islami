import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/models/azkar_model/azkar_model.dart';
import 'package:islami/widgets/loading_indicator.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 1;
  int index = 0;
  double angel = 0.0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: FutureBuilder(
          future: AzkarModel.loadAzkarData("تسابيح"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('something went wrong'));
            } else {
              final azkar = snapshot.data!;
              return Column(
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
                    onTap: () {
                      onIncreaseCounter(azkar);
                    },
                    child: Stack(
                      children: [
                        Transform.rotate(
                          angle: angel,
                          child: Image.asset('assets/images/sebhabody1.png'),
                        ),
                        Center(
                          child: SizedBox(
                            height: size.height * .4,
                            child: Column(
                              mainAxisAlignment: .center,
                              children: [
                                SizedBox(
                                  width: size.width * .7,
                                  child: AutoSizeText(
                                    azkar[index].content!,
                                    style: textTheme.displaySmall,
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '$counter',
                                  style: textTheme.displaySmall!.copyWith(
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AutoSizeText(
                    'عدد المرات: ${azkar[index].count}',
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.primary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    azkar[index].description!,
                    style: textTheme.titleMedium,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void onIncreaseCounter(List<AzkarModel> azkar) {
    counter++;
    angel++;
    if (counter > int.parse(azkar[index].count!)) {
      index++;
      counter = 1;
      angel = 0;
      if (index >= azkar.length) {
        index = 0;
      }
    }
    setState(() {});
  }
}
