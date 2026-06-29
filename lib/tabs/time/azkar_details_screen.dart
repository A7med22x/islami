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
      body: FutureBuilder(
        future: AzkarModel.loadAzkarData(azkarName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          }

          if (snapshot.hasError) {
            return const Center(child: Text('something went wrong'));
          }

          final azkar = snapshot.data!;

          return ListView.builder(
            itemCount: azkar.length,
            itemBuilder: (_, index) {
              if (azkar[index].count!.isNotEmpty) {
                int count = int.tryParse(azkar[index].count!) ?? 0;

                return Container(
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
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 10),

                      if (azkar[index].description!.isNotEmpty)
                        Text(
                          azkar[index].description!,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppTheme.brown, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(height: 10),
                      if (azkar[index].count!.isNotEmpty)
                      StatefulBuilder(
                        builder: (context, setItemState) {
                          return InkWell(
                            onTap: () {
                              setItemState(() {
                                if (count > 0) {
                                  count--;
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),

                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppTheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),

                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setItemState(() {
                                        count =
                                            int.tryParse(azkar[index].count!) ??
                                            0;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.refresh,
                                      color: AppTheme.primary,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  Text(
                                    '$count',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppTheme.primary),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppTheme.black,
                  border: Border.all(color: AppTheme.primary, width: 2),
                ),
                child: Text(azkar[index].content!, textAlign: TextAlign.center),
              );
            },
          );
        },
      ),
    );
  }
}
