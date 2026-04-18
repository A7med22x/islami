import 'dart:async';

import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

// ignore: must_be_immutable
class NextPrayerTimer extends StatefulWidget {
  NextPrayerTimer({super.key, required this.timeRemaining});

  Duration timeRemaining;

  @override
  State<NextPrayerTimer> createState() => _NextPrayerTimerState();
}

class _NextPrayerTimerState extends State<NextPrayerTimer> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (widget.timeRemaining.inSeconds > 0) {
          widget.timeRemaining -= Duration(seconds: 1);
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  String _formatDuration(Duration time) {
    final hours = time.inHours.toString().padLeft(2, '0');
    final minutes = time.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = time.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Next Pray - ${_formatDuration(widget.timeRemaining)}',
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppTheme.black),
        ),
        TextButton(
          onPressed: () {},
          child: Icon(Icons.volume_off, size: 24, color: AppTheme.black),
        ),
      ],
    );
  }
}
