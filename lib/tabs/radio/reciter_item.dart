import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/models/reciters_response/moshaf.dart';
import 'package:islami/models/reciters_response/reciters_moshaf.dart';
import 'package:islami/provider/radio_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:islami/tabs/quran/quran_service.dart';
import 'package:provider/provider.dart';

class ReciterItem extends StatefulWidget {
  const ReciterItem({super.key, required this.name, required this.moshaf});

  final String name;
  final Moshaf moshaf;

  @override
  State<ReciterItem> createState() => _ReciterItemState();
}

class _ReciterItemState extends State<ReciterItem> {
  bool isVolumeUp = true;
  RecitersMoshaf? selectedSurah;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RadioProvider>();
    final availableSurahs = widget.moshaf.availableSurahs
        .map(
          (id) => RecitersMoshaf(
            name: QuranService.arabicSuraName[id - 1],
            code: id.toString().padLeft(3, '0'),
          ),
        )
        .toList();

    final server = widget.moshaf.server!;

    final isActive =
        provider.currentReciterName == widget.name &&
        provider.currentSurah?.code == selectedSurah?.code;

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isActive
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
            selectedItem: selectedSurah,
            items: (filter, _) {
              return availableSurahs
                  .where((surah) => surah.name.contains(filter))
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
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppTheme.black),
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
              menuProps: MenuProps(backgroundColor: AppTheme.primary),
            ),
            onSelected: (RecitersMoshaf? value) {
              setState(() {
                selectedSurah = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (selectedSurah == null) return;

                  provider.playReciter(
                    reciterName: widget.name,
                    server: server,
                    playlist: availableSurahs,
                    initialIndex: availableSurahs.indexWhere(
                      (e) => e.code == selectedSurah!.code,
                    ),
                  );
                },
                icon: Icon(
                  isActive &&
                          provider.currentSurah?.code == selectedSurah?.code &&
                          provider.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 45,
                  color: AppTheme.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (provider.currentReciterName == widget.name) {
                    provider.stop();
                  }
                },
                icon: const Icon(
                  Icons.stop_rounded,
                  size: 40,
                  color: AppTheme.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isVolumeUp = !isVolumeUp;
                  });

                  provider.setVolume(isVolumeUp ? 1.0 : 0.0);
                },
                icon: Icon(
                  isVolumeUp ? Icons.volume_up : Icons.volume_off,
                  size: 40,
                  color: AppTheme.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
