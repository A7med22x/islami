import 'package:islami/tabs/quran/quran_service.dart';

class RecitersMoshaf {
  String name;
  String code;

  RecitersMoshaf({required this.name, required this.code});

  static List<RecitersMoshaf> reciterMoshaf = List.generate(
    QuranService.arabicSuraName.length,
    (index) => RecitersMoshaf(
      name: QuranService.arabicSuraName[index],
      code: (index + 1).toString().padLeft(3, '0'),
    ),
  );
}