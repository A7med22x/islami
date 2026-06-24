import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/quran/quran_service.dart';
import 'package:islami/tabs/quran/sura.dart';
import 'package:islami/utils/arabic_utils.dart';
import 'package:islami/widgets/loading_indicator.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const routeName = '/sura details';

  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  late Sura sura;
  String ayat = '';
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isLoaded) {
      sura = ModalRoute.of(context)!.settings.arguments as Sura;
      isLoaded = true;
      loadSura();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(sura.arabicName, style: textTheme.bodyLarge)),
      body: Column(
        crossAxisAlignment: .center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/leftheader.png',
                  height: MediaQuery.sizeOf(context).height * .1,
                  width: MediaQuery.sizeOf(context).width * .1,
                  fit: .fill,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(sura.arabicName, style: textTheme.bodyLarge),
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            'اّياتها\n${ArabicUtils.numberToArabic(sura.ayatCount)}',
                            textAlign: .center,
                            style: textTheme.bodyLarge!.copyWith(
                              fontSize: 24,
                              height: 1,
                            ),
                          ),
                          Text(
                            sura.makkia ? "مكية\n" : "مدنية\n",
                            style: textTheme.bodyLarge!.copyWith(
                              fontSize: 20,
                              height: 1,
                            ),
                          ),
                          Text(
                            'ترتيبها\n${ArabicUtils.numberToArabic(sura.suraNumber)}',
                            textAlign: .center,
                            style: textTheme.bodyLarge!.copyWith(
                              fontSize: 24,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/right_header.png',
                  height: MediaQuery.sizeOf(context).height * .1,
                  width: MediaQuery.sizeOf(context).width * .1,
                  fit: .fill,
                ),
              ],
            ),
          ),
          Divider(color: AppTheme.primary, indent: 16, endIndent: 16),
          Expanded(
            child: ayat.isEmpty
                ? LoadingIndicator()
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    child: Text(
                      ayat,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge,
                    ),
                  ),
          ),
          Stack(
            children: [
              Image.asset(
                'assets/images/footer.png',
                height: MediaQuery.sizeOf(context).height * .08,
                width: .infinity,
                fit: .fill,
              ),
              Positioned(
                right: 16,
                bottom: 8,
                child: TextButton(
                  onPressed: nextSura,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppTheme.primary),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'التالي',
                      style: textTheme.bodyLarge!.copyWith(
                        color: AppTheme.white,
                        fontSize: 24,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 8,
                child: TextButton(
                  onPressed: previousSura,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppTheme.primary),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'السابق',
                      style: textTheme.bodyLarge!.copyWith(
                        color: AppTheme.white,
                        fontSize: 24,
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> loadSura() async {
    ayat = '';

    String suraFileContent = await QuranService.loadSoraFile(sura.suraNumber);

    List<String> verses = suraFileContent.split('\r\n');

    String bismillah = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ';

    if (sura.suraNumber != 1 && sura.suraNumber != 9) {
      ayat += '$bismillah\n';
    }

    int ayahNumber = 1;

    for (String ayah in verses) {
      ayah = ayah.trim();
      if (ayah.isEmpty) continue;

      ayat += '$ayah ${ArabicUtils.numberToArabic(ayahNumber)} ';

      ayahNumber++;
    }

    if (mounted) {
      setState(() {});
    }
  }

  void nextSura() {
    if (sura.suraNumber < 114) {
      setState(() {
        sura = QuranService.suras[sura.suraNumber];
        ayat = '';
      });

      loadSura();
    }
  }

  void previousSura() {
    if (sura.suraNumber > 1) {
      setState(() {
        sura = QuranService.suras[sura.suraNumber - 2];
        ayat = '';
      });

      loadSura();
    }
  }
}
