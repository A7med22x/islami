import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islami/api/api_manager.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/time/azkar_section.dart';
import 'package:islami/tabs/time/next_prayer_timer.dart';
import 'package:islami/tabs/time/prayer_date_header.dart';
import 'package:islami/tabs/time/prayer_item.dart';
import 'package:islami/utils/data_formatter.dart';
import 'package:islami/widgets/loading_indicator.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            height: size.height * 0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppTheme.lightBrown,
              image: DecorationImage(
                image: AssetImage('assets/images/prayer_time_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: FutureBuilder(
              future: ApiManager.getPrayer(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text('something went wrong'));
                } else {
                  final data = snapshot.data!;
                  Map<String, dynamic> prayerTimes =
                      DataFormatter.sortPrayerTimes(
                        data.data!.timings!.toJson(),
                      );

                  Map<String, dynamic> prayerCountdown =
                      DataFormatter.getNextPrayer(prayerTimes);

                  return Stack(
                    children: [
                      Positioned(
                        top: 14,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            PrayerDateHeader(
                              gregorianDate: data.data!.date!.gregorian!,
                              hijriDate: data.data!.date!.hijri!,
                              day: data.data!.date!.gregorian!.weekday!.en!,
                            ),
                            const SizedBox(height: 20),
                            CarouselSlider.builder(
                              itemBuilder: (context, index, realIndex) {
                                String key = prayerTimes.keys.elementAt(index);
                                String value = DataFormatter.formatTime(
                                  prayerTimes.values.elementAt(index),
                                ).toString().substring(0, 5);
                                String pmOrAm = DataFormatter.formatTime(
                                  prayerTimes.values.elementAt(index),
                                ).toString().substring(5);
                                return PrayerItem(
                                  name: key,
                                  time: value,
                                  pmOrAm: pmOrAm,
                                );
                              },
                              itemCount: prayerTimes.length,
                              options: CarouselOptions(
                                enlargeCenterPage: true,
                                height: size.height * 0.15,
                                enlargeFactor: 0.35,
                                viewportFraction: 0.35,
                              ),
                            ),
                            const SizedBox(height: 20),
                            NextPrayerTimer(
                              timeRemaining:
                                  prayerCountdown[prayerTimes.keys.first],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          AzkarSection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
