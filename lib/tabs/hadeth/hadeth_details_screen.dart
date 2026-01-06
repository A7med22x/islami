import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/hadeth/hadeth.dart';

class HadethDetailsScreen extends StatefulWidget {
  static const routeName = '/hadeth details';

  @override
  State<HadethDetailsScreen> createState() => _HadethDetailsScreenState();
}

class _HadethDetailsScreenState extends State<HadethDetailsScreen> {
  late Hadeth hadeth;

  @override
  Widget build(BuildContext context) {
    hadeth = ModalRoute.of(context)!.settings.arguments as Hadeth;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text('Hadeth ${hadeth.num}')),
      body: Column(
        crossAxisAlignment: .center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Image.asset('assets/images/leftheader.png'),
                Expanded(
                  child: Text(
                    hadeth.title,
                    style: textTheme.headlineSmall!.copyWith(
                      color: AppTheme.primary,
                    ),
                    textAlign: .center,
                  ),
                ),
                Image.asset('assets/images/right_header.png'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (_, index) => Text(
                hadeth.content[index],
                style: textTheme.titleLarge!.copyWith(color: AppTheme.primary),
                textAlign: .center,
              ),
              separatorBuilder: (_, _) => SizedBox(height: 10),
              itemCount: hadeth.content.length,
            ),
          ),
          Image.asset('assets/images/footer.png'),
        ],
      ),
    );
  }
}
