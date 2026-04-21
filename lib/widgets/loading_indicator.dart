import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;

  const LoadingIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color ?? AppTheme.primary),
    );
  }
}
