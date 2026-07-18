import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islami/api/api_manager.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/radio/radio_item.dart';
import 'package:islami/tabs/radio/reciter_item.dart';
import 'package:islami/tabs/radio/tafsir_item.dart';
import 'package:islami/widgets/loading_indicator.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  String _searchQuery = "";
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              style: textTheme.titleMedium,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/radio.svg',
                  colorFilter: ColorFilter.mode(
                    AppTheme.primary,
                    BlendMode.srcIn,
                  ),
                  width: 28,
                  height: 28,
                  fit: .scaleDown,
                ),
              ),
              onChanged: (query) {
                _searchQuery = query;
                setState(() {});
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
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
                  Tab(child: Text('Tafasir')),
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
                        return Center(child: Text('check your internet connection'));
                      } else {
                        final radios = snapshot.data!;
                        final filteredRadios = radios
                            .where((r) => r.name.contains(_searchQuery))
                            .toList();

                        return ListView.builder(
                          itemBuilder: (context, index) => RadioItem(
                            name: filteredRadios[index].name,
                            url: filteredRadios[index].url,
                          ),
                          itemCount: filteredRadios.length,
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
                        return Center(child: Text('check your internet connection'));
                      } else {
                        final reciters = snapshot.data!;
                        final filteredReciters = reciters
                            .where((r) => r.name.contains(_searchQuery))
                            .toList();

                        return ListView.builder(
                          itemBuilder: (context, index) => ReciterItem(
                            name: filteredReciters[index].name,
                            moshaf: filteredReciters[index].moshaf.first,
                          ),
                          itemCount: filteredReciters.length,
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: ApiManager().getTafasirData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingIndicator();
                      } else if (snapshot.hasError) {
                        return Center(child: Text('check your internet connection'));
                      } else {
                        final tafasir = snapshot.data!;
                        final filteredTafasir = tafasir
                            .where((t) => t.name.contains(_searchQuery))
                            .toList();

                        return ListView.builder(
                          itemBuilder: (context, index) =>
                              TafsirItem(tafsir: filteredTafasir[index]),
                          itemCount: filteredTafasir.length,
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
