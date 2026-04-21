import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/models/reciters_response/reciters_moshaf.dart';
import 'package:islami/provider/radio_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';


class ReciterItem extends StatefulWidget {
  const ReciterItem({super.key, required this.name, required this.url});

  final String name;
  final String url;

  @override
  State<ReciterItem> createState() => _ReciterItemState();
}

class _ReciterItemState extends State<ReciterItem> {
  bool isVolumeUp = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<RadioProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  (provider.isPlaying &&
                      provider.currentPlayingURL == widget.url)
                  ? AssetImage('assets/images/sound_wave.png')
                  : AssetImage('assets/images/mosque.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.primary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  widget.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: AppTheme.black),
                ),
              ),
              DropdownSearch<RecitersMoshaf>(
                selectedItem: provider.selectedReciter,
                items: (filter, _) {
                  return RecitersMoshaf.reciterMoshaf
                      .where((reciter) => reciter.name.contains(filter))
                      .toList();
                },
                itemAsString: (item) => item.name,
                compareFn: (item1, item2) {
                  return item1.code == item2.code;
                },
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem?.name ?? "اختر سورة",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppTheme.white),
                  );
                },
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: 'ابحث عن سورة...',
                      hintStyle: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: AppTheme.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppTheme.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppTheme.black),
                      ),
                      filled: true,
                      fillColor: AppTheme.primary,
                    ),
                  ),
                  menuProps: MenuProps(
                    backgroundColor: AppTheme.primary,
                  ),
                ),
                onSelected: (RecitersMoshaf? newValue) {
                  provider.setSelectedReciter(newValue);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      provider.play(widget.url);
                    },
                    icon: Icon(
                      (provider.isPlaying &&
                              provider.currentPlayingURL == widget.url)
                          ? Icons.pause
                          : Icons.play_arrow_rounded,
                      size: 50,
                      color: AppTheme.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (provider.isPlaying &&
                          provider.currentPlayingURL == widget.url) {
                        provider.stop();
                      }
                    },
                    icon: Icon(
                      Icons.stop_rounded,
                      size: 40,
                      color: AppTheme.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      isVolumeUp = !isVolumeUp;
                      provider.setVolume(isVolumeUp ? 2 : 0);
                    },
                    icon: Icon(
                      isVolumeUp ? Icons.volume_up : Icons.volume_mute,
                      size: 40,
                      color: AppTheme.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
