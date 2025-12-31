import 'package:flutter/material.dart';
import 'package:islami/nab_var_unselected_Icons.dart';
import 'package:islami/nab_var_selected_Icons.dart';
import 'package:islami/tabs/hadeth/hadeth_tab.dart';
import 'package:islami/tabs/quran/quran_tab.dart';
import 'package:islami/tabs/radio/radio_tab.dart';
import 'package:islami/tabs/sedha/sebha_tab.dart';
import 'package:islami/tabs/time/time_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    QuranTab(),
    HadethTab(),
    SebhaTab(),
    RadioTab(),
    TimeTab(),
  ];
  List<String> backgroundImageNames = [
    'quran',
    'hadeth',
    'sebha',
    'radio',
    'time',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/${backgroundImageNames[currentIndex]}_background.png',
            ),
            fit: .fill,
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/header.png',
              height: MediaQuery.sizeOf(context).height * .15,
              fit: .fitWidth,
            ),
            tabs[currentIndex],
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: NabVarUnselectedIcons(imageName: 'quran'),
            activeIcon: NabVarSelectedIcons(imageName: 'quran'),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            icon: NabVarUnselectedIcons(imageName: 'hadeth'),
            activeIcon: NabVarSelectedIcons(imageName: 'hadeth'),
            label: 'Hadeth',
          ),
          BottomNavigationBarItem(
            icon: NabVarUnselectedIcons(imageName: 'sebha'),
            activeIcon: NabVarSelectedIcons(imageName: 'sebha'),
            label: 'Sebha',
          ),
          BottomNavigationBarItem(
            icon: NabVarUnselectedIcons(imageName: 'radio'),
            activeIcon: NabVarSelectedIcons(imageName: 'radio'),
            label: 'Radio',
          ),
          BottomNavigationBarItem(
            icon: NabVarUnselectedIcons(imageName: 'time'),
            activeIcon: NabVarSelectedIcons(imageName: 'time'),
            label: 'Time',
          ),
        ],
      ),
    );
  }
}
