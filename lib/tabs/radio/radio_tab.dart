import 'package:flutter/material.dart';
import 'package:islami/api/api_manager.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/radio/radio_item.dart';
import 'package:islami/widgets/loading_indicator.dart';

class RadioTab extends StatelessWidget {
  const RadioTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.black.withValues(alpha: 0.7),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.primary,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppTheme.primary,
                dividerHeight: 0,
                unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
                labelStyle: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: AppTheme.black),
                tabs: [
                  Tab(child: Text('Radio')),
                  Tab(child: Text('Reciters')),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder(
                    future: ApiManager().getRadioData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingIndicator();
                      } else if (snapshot.hasError) {
                        return Center(child: Text('something went wrong'));
                      } else {
                        final radios = snapshot.data!;
                        return ListView.builder(
                          itemBuilder: (context, index) => RadioItem(
                            name: radios[index].name,
                            url: radios[index].url,
                          ),
                          itemCount: radios.length,
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: ApiManager().getReciterData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingIndicator();
                      } else if (snapshot.hasError) {
                        return Center(child: Text('something went wrong'));
                      } else {
                        final reciters = snapshot.data!;
                        return ListView.builder(
                          itemBuilder: (context, index) => RadioItem(
                            name: reciters[index].name,
                            url: '${reciters[index].moshaf[0].server}002.mp3',
                          ),
                          itemCount: reciters.length,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
