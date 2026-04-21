import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/models/azkar_model/azkar_model.dart';
import 'package:islami/widgets/loading_indicator.dart';

class AzkarDetailsScreen extends StatefulWidget {
  static const routeName = '/azkar details';

  const AzkarDetailsScreen({super.key});

  @override
  State<AzkarDetailsScreen> createState() => _AzkarDetailsScreenState();
}

class _AzkarDetailsScreenState extends State<AzkarDetailsScreen> {
  late String azkarName;

  @override
  Widget build(BuildContext context) {
    azkarName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: AutoSizeText(azkarName, maxLines: 1)),
      body: Column(
        children: [
          FutureBuilder(
            future: AzkarModel.loadAzkarData(azkarName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text('something went wrong'));
              } else {
                final azkar = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, index) => Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.black,
                        border: Border.all(color: AppTheme.primary, width: 2),
                      ),
                      child: Column(
                        children: [
                          Text(
                            azkar[index].content!,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'عدد المرات: ${azkar[index].count}',
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(color: AppTheme.primary),
                            textAlign: TextAlign.center,
                          ),
                          if (azkar[index].description!.isNotEmpty)
                            Text(
                              azkar[index].description!,
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(color: AppTheme.brown),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ),
                    itemCount: azkar.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
