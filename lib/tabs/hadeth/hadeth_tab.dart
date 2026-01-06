import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:islami/tabs/hadeth/hadeth_item.dart';

class HadethTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 50,
      itemBuilder: (_, index, _) => HadethItem(),
      options: CarouselOptions(
        height: .infinity,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
      ),
    );
  }
}
