import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreens extends StatelessWidget {
  static const String routeName = '/intro';
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: textTheme.headlineSmall!.copyWith(
        color: AppTheme.primary,
      ),
      bodyTextStyle: textTheme.titleMedium!.copyWith(color: AppTheme.primary),
      bodyAlignment: .bottomCenter,
      imageFlex: 2,
      bodyFlex: 1,
    );
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/header.png'),
          Expanded(
            child: IntroductionScreen(
              bodyPadding: EdgeInsets.only(top: 30),
              infiniteAutoScroll: false,
              pages: [
                PageViewModel(
                  title: 'Welcome To Islmi App',
                  bodyWidget: SizedBox.shrink(),
                  image: Center(
                    child: Image.asset('assets/images/introscreen1.png'),
                  ),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: 'Welcome To Islmi',
                  body: 'We Are Very Excited To Have You In Our Community',
                  image: Image.asset('assets/images/introscreen2.png'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: 'Reading the Quran',
                  body: 'Read, and your Lord is the Most Generous',
                  image: Image.asset('assets/images/introscreen3.png'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: 'Bearish',
                  body: 'Praise the name of your Lord, the Most High',
                  image: Image.asset('assets/images/introscreen4.png'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: 'Holy Quran Radio',
                  body:
                      'You can listen to the Holy Quran Radio through the application for free and easily',
                  image: Image.asset('assets/images/introscreen5.png'),
                  decoration: pageDecoration,
                ),
              ],
              showNextButton: true,
              showBackButton: true,
              showDoneButton: true,
              next: Text(
                'Next',
                style: textTheme.titleSmall!.copyWith(color: AppTheme.primary),
              ),
              back: Text(
                'Back',
                style: textTheme.titleSmall!.copyWith(color: AppTheme.primary),
              ),
              done: Text(
                'Finish',
                style: textTheme.titleSmall!.copyWith(color: AppTheme.primary),
              ),
              onDone: () async{
                SharedPreferences sharedPref = await SharedPreferences.getInstance();
                sharedPref.setBool('hasSeenIntro', true);
                Navigator.of(
                  context,
                ).pushReplacementNamed(HomeScreen.routeName);
              },
              dotsDecorator: DotsDecorator(
                activeSize: Size(18, 7),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
 }
