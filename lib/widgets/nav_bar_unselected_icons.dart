import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami/app_theme.dart';

class NavBarUnselectedIcons extends StatelessWidget {
  final String imageName;

  const NavBarUnselectedIcons({super.key, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$imageName.svg',
      colorFilter: ColorFilter.mode(AppTheme.black, BlendMode.srcIn),
      height: 28,
      width: 28,
      fit: .fill,
    );
  }
}
