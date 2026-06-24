import 'package:flutter/services.dart';
import 'package:islami/tabs/quran/sura.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranService {
  static List<String> arabicSuraName = [
    'الفاتحة',
    'البقرة',
    'آل عمران',
    'النساء',
    'المائدة',
    'الأنعام',
    'الأعراف',
    'الأنفال',
    'التوبة',
    'يونس',
    'هود',
    'يوسف',
    'الرعد',
    'إبراهيم',
    'الحجر',
    'النحل',
    'الإسراء',
    'الكهف',
    'مريم',
    'طه',
    'الأنبياء',
    'الحج',
    'المؤمنون',
    'النّور',
    'الفرقان',
    'الشعراء',
    'النّمل',
    'القصص',
    'العنكبوت',
    'الرّوم',
    'لقمان',
    'السجدة',
    'الأحزاب',
    'سبأ',
    'فاطر',
    'يس',
    'الصافات',
    'ص',
    'الزمر',
    'غافر',
    'فصّلت',
    'الشورى',
    'الزخرف',
    'الدّخان',
    'الجاثية',
    'الأحقاف',
    'محمد',
    'الفتح',
    'الحجرات',
    'ق',
    'الذاريات',
    'الطور',
    'النجم',
    'القمر',
    'الرحمن',
    'الواقعة',
    'الحديد',
    'المجادلة',
    'الحشر',
    'الممتحنة',
    'الصف',
    'الجمعة',
    'المنافقون',
    'التغابن',
    'الطلاق',
    'التحريم',
    'الملك',
    'القلم',
    'الحاقة',
    'المعارج',
    'نوح',
    'الجن',
    'المزّمّل',
    'المدّثر',
    'القيامة',
    'الإنسان',
    'المرسلات',
    'النبأ',
    'النازعات',
    'عبس',
    'التكوير',
    'الإنفطار',
    'المطفّفين',
    'الإنشقاق',
    'البروج',
    'الطارق',
    'الأعلى',
    'الغاشية',
    'الفجر',
    'البلد',
    'الشمس',
    'الليل',
    'الضحى',
    'الشرح',
    'التين',
    'العلق',
    'القدر',
    'البينة',
    'الزلزلة',
    'العاديات',
    'القارعة',
    'التكاثر',
    'العصر',
    'الهمزة',
    'الفيل',
    'قريش',
    'الماعون',
    'الكوثر',
    'الكافرون',
    'النصر',
    'المسد',
    'الإخلاص',
    'الفلق',
    'الناس',
  ];
  static List<String> englishSuraName = [
    'Al-Fatiha',
    'Al-Baqarah',
    'Aal-E-Imran',
    'An-Nisa',
    'Al-Maidah',
    'Al-Anam',
    'Al-Araf',
    'Al-Anfal',
    'At-Tawbah',
    'Yunus',
    'Hud',
    'Yusuf',
    'Ar-Rad',
    'Ibrahim',
    'Al-Hijr',
    'An-Nahl',
    'Al-Isra',
    'Al-Kahf',
    'Maryam',
    'Ta-Ha',
    'Al-Anbiya',
    'Al-Hajj',
    'Al-Muminun',
    'An-Nur',
    'Al-Furqan',
    'Ash-Shuara',
    'An-Naml',
    'Al-Qasas',
    'Al-Ankabut',
    'Ar-Rum',
    'Luqman',
    'As-Sajda',
    'Al-Ahzab',
    'Saba',
    'Fatir',
    'Ya-Sin',
    'As-Saffat',
    'Sad',
    'Az-Zumar',
    'Ghafir',
    'Fussilat',
    'Ash-Shura',
    'Az-Zukhruf',
    'Ad-Dukhan',
    'Al-Jathiya',
    'Al-Ahqaf',
    'Muhammad',
    'Al-Fath',
    'Al-Hujurat',
    'Qaf',
    'Adh-Dhariyat',
    'At-Tur',
    'An-Najm',
    'Al-Qamar',
    'Ar-Rahman',
    'Al-Waqia',
    'Al-Hadid',
    'Al-Mujadila',
    'Al-Hashr',
    'Al-Mumtahina',
    'As-Saff',
    'Al-Jumua',
    'Al-Munafiqun',
    'At-Taghabun',
    'At-Talaq',
    'At-Tahrim',
    'Al-Mulk',
    'Al-Qalam',
    'Al-Haqqah',
    'Al-Maarij',
    'Nuh',
    'Al-Jinn',
    'Al-Muzzammil',
    'Al-Muddathir',
    'Al-Qiyamah',
    'Al-Insan',
    'Al-Mursalat',
    'An-Naba',
    'An-Naziat',
    'Abasa',
    'At-Takwir',
    'Al-Infitar',
    'Al-Mutaffifin',
    'Al-Inshiqaq',
    'Al-Buruj',
    'At-Tariq',
    'Al-Ala',
    'Al-Ghashiyah',
    'Al-Fajr',
    'Al-Balad',
    'Ash-Shams',
    'Al-Lail',
    'Ad-Duha',
    'Ash-Sharh',
    'At-Tin',
    'Al-Alaq',
    'Al-Qadr',
    'Al-Bayyina',
    'Az-Zalzalah',
    'Al-Adiyat',
    'Al-Qaria',
    'At-Takathur',
    'Al-Asr',
    'Al-Humazah',
    'Al-Fil',
    'Quraysh',
    'Al-Maun',
    'Al-Kawthar',
    'Al-Kafirun',
    'An-Nasr',
    'Al-Masad',
    'Al-Ikhlas',
    'Al-Falaq',
    'An-Nas',
  ];
  static List<int> ayatCounts = [
    7,
    286,
    200,
    176,
    120,
    165,
    206,
    75,
    129,
    109,
    123,
    111,
    43,
    52,
    99,
    128,
    111,
    110,
    98,
    135,
    112,
    78,
    118,
    64,
    77,
    227,
    93,
    88,
    69,
    60,
    34,
    30,
    73,
    54,
    45,
    83,
    182,
    88,
    75,
    85,
    54,
    53,
    89,
    59,
    37,
    35,
    38,
    29,
    18,
    45,
    60,
    49,
    62,
    55,
    78,
    96,
    29,
    22,
    24,
    13,
    14,
    11,
    11,
    18,
    12,
    12,
    30,
    52,
    52,
    44,
    28,
    28,
    20,
    56,
    40,
    31,
    50,
    40,
    46,
    42,
    29,
    19,
    36,
    25,
    22,
    17,
    19,
    26,
    30,
    20,
    15,
    21,
    11,
    8,
    5,
    19,
    5,
    8,
    8,
    11,
    11,
    8,
    3,
    9,
    5,
    4,
    6,
    3,
    6,
    3,
    5,
    4,
    5,
    6,
  ];
  static List<bool> makkia = [
    true, // الفاتحة
    false, // البقرة
    false, // آل عمران
    false, // النساء
    false, // المائدة
    true, // الأنعام
    true, // الأعراف
    false, // الأنفال
    false, // التوبة
    true, // يونس
    true, // هود
    true, // يوسف
    false, // الرعد
    true, // إبراهيم
    true, // الحجر
    true, // النحل
    true, // الإسراء
    true, // الكهف
    true, // مريم
    true, // طه
    true, // الأنبياء
    false, // الحج
    true, // المؤمنون
    false, // النور
    true, // الفرقان
    true, // الشعراء
    true, // النمل
    true, // القصص
    true, // العنكبوت
    true, // الروم
    true, // لقمان
    true, // السجدة
    false, // الأحزاب
    true, // سبأ
    true, // فاطر
    true, // يس
    true, // الصافات
    true, // ص
    true, // الزمر
    true, // غافر
    true, // فصلت
    true, // الشورى
    true, // الزخرف
    true, // الدخان
    true, // الجاثية
    true, // الأحقاف
    false, // محمد
    false, // الفتح
    false, // الحجرات
    true, // ق
    true, // الذاريات
    true, // الطور
    true, // النجم
    true, // القمر
    false, // الرحمن
    true, // الواقعة
    false, // الحديد
    false, // المجادلة
    false, // الحشر
    false, // الممتحنة
    false, // الصف
    false, // الجمعة
    false, // المنافقون
    false, // التغابن
    false, // الطلاق
    false, // التحريم
    true, // الملك
    true, // القلم
    true, // الحاقة
    true, // المعارج
    true, // نوح
    true, // الجن
    true, // المزمل
    true, // المدثر
    true, // القيامة
    false, // الإنسان
    true, // المرسلات
    true, // النبأ
    true, // النازعات
    true, // عبس
    true, // التكوير
    true, // الإنفطار
    true, // المطففين
    true, // الإنشقاق
    true, // البروج
    true, // الطارق
    true, // الأعلى
    true, // الغاشية
    true, // الفجر
    true, // البلد
    true, // الشمس
    true, // الليل
    true, // الضحى
    true, // الشرح
    true, // التين
    true, // العلق
    true, // القدر
    false, // البينة
    false, // الزلزلة
    true, // العاديات
    true, // القارعة
    true, // التكاثر
    true, // العصر
    true, // الهمزة
    true, // الفيل
    true, // قريش
    true, // الماعون
    true, // الكوثر
    true, // الكافرون
    false, // النصر
    true, // المسد
    true, // الإخلاص
    true, // الفلق
    true, // الناس
  ];

  
  static List<Sura> suras = List.generate(
    114,
    (index) => getSuraFromIndex(index),
  );

  static List<Sura> mostRecently = [];

  static Sura getSuraFromIndex(int index) => Sura(
    englishName: englishSuraName[index],
    arabicName: arabicSuraName[index],
    ayatCount: ayatCounts[index],
    suraNumber: index + 1,
    makkia: makkia[index],
  );

  static Future<String> loadSoraFile(int suraNumber) =>
      rootBundle.loadString('assets/texts/$suraNumber.txt');

  static void searchSura(String query) {
    suras.clear();
    for (int i = 0; i < 114; i++) {
      if (arabicSuraName[i].contains(query) ||
          englishSuraName[i].toLowerCase().contains(query.toLowerCase())) {
        Sura sura = getSuraFromIndex(i);
        suras.add(sura);
      }
    }
  }

  static Future<void> getMostRecentlySuras() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    List<String>? mostRecentlyIndexes = sharedPref.getStringList(
      'mostRecentlyIndexes',
    );
    if (mostRecentlyIndexes == null) return;
    mostRecently = mostRecentlyIndexes.map((indexString) {
      int index = int.parse(indexString);
      Sura sura = getSuraFromIndex(index);
      return sura;
    }).toList();
  }

  static Future<void> addToMostRecently(Sura sura) async {
    mostRecently.removeWhere(
      (mostRecentSura) => mostRecentSura.suraNumber == sura.suraNumber,
    );

    mostRecently.insert(0, sura);

    if (mostRecently.length > 10) {
      mostRecently.removeLast();
    }

    List<String> mostRecentlyIndexes = mostRecently
        .map((sura) => (sura.suraNumber - 1).toString())
        .toList();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setStringList('mostRecentlyIndexes', mostRecentlyIndexes);
  }
}
