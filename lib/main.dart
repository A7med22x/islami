import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/home_screen.dart';
import 'package:islami/intro_screens.dart';
import 'package:islami/provider/radio_provider.dart';
import 'package:islami/tabs/hadeth/hadeth_details_screen.dart';
import 'package:islami/tabs/quran/quran_service.dart';
import 'package:islami/tabs/quran/sura_details_screen.dart';
import 'package:islami/tabs/time/azkar_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await QuranService.getMostRecentlySuras();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  final hasSeenIntro = sharedPref.getBool('hasSeenIntro') ?? false;
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => RadioProvider(),
      child: IslmiApp(hasSeenIntro: hasSeenIntro),
    ),
  );
}

class IslmiApp extends StatelessWidget {
  final bool hasSeenIntro;
  const IslmiApp({super.key, required this.hasSeenIntro});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        SuraDetailsScreen.routeName: (_) => SuraDetailsScreen(),
        IntroScreens.routeName: (_) => IntroScreens(),
        HadethDetailsScreen.routeName: (_) => HadethDetailsScreen(),
        AzkarDetailsScreen.routeName: (_) => AzkarDetailsScreen(),
      },
      initialRoute: hasSeenIntro
          ? HomeScreen.routeName
          : IntroScreens.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
