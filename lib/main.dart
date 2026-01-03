import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/home_screen.dart';
import 'package:islami/intro_screens.dart';
import 'package:islami/tabs/quran/quran_service.dart';
import 'package:islami/tabs/quran/sura_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await QuranService.getMostRecentlySuras();
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  final hasSeenIntro= await sharedPref.getBool('hasSeenIntro') ?? false;
    runApp(IslmiApp(hasSeenIntro: hasSeenIntro,));
}

class IslmiApp extends StatelessWidget {
  final bool hasSeenIntro;
  const IslmiApp({required this.hasSeenIntro});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        SuraDetailsScreen.routeName: (_) => SuraDetailsScreen(),
        IntroScreens.routeName: (_) => IntroScreens(),
      },
      initialRoute: hasSeenIntro ? HomeScreen.routeName : IntroScreens.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
