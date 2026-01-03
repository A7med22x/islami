import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/quran/quran_service.dart';
import 'package:islami/tabs/quran/sura.dart';
import 'package:islami/widgets/loading_indicator.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const routeName = '/sura details';

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  late Sura sura;
  List<String> ayat = [];

  @override
  Widget build(BuildContext context) {
    sura = ModalRoute.of(context)!.settings.arguments as Sura;
    TextTheme textTheme = Theme.of(context).textTheme;
    if (ayat.isEmpty) {
      loadSura();
    }
    return Scaffold(
      appBar: AppBar(title: Text(sura.englishName)),
      body: Column(
        crossAxisAlignment: .center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Image.asset('assets/images/leftheader.png'),
                Text(
                  sura.arabicName,
                  style: textTheme.headlineSmall!.copyWith(
                    color: AppTheme.primary,
                  ),
                ),
                Image.asset('assets/images/right_header.png'),
              ],
            ),
          ),
          Expanded(
            child: ayat.isEmpty
                ? LoadingIndicator()
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (_, index) => Text(
                      ayat[index],
                      style: textTheme.titleLarge!.copyWith(
                        color: AppTheme.primary,
                      ),
                      textAlign: .center,
                    ),
                    separatorBuilder: (_, _) => SizedBox(height: 10),
                    itemCount: ayat.length,
                  ),
          ),
          Image.asset('assets/images/footer.png'),
        ],
      ),
    );
  }

  Future<void> loadSura() async {
    String suraFileContent = await QuranService.loadSoraFile(sura.suraNumber);
    ayat = suraFileContent.split('\r \n');
    setState(() {});
  }
}
