import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/models/reciters_response/reciters_moshaf.dart';
import 'package:islami/models/tafasir/tafsir.dart';
import 'package:islami/provider/radio_provider.dart';
import 'package:provider/provider.dart';

class TafsirItem extends StatefulWidget {
  const TafsirItem({super.key, required this.tafsir});

  final Tafsir tafsir;

  @override
  State<TafsirItem> createState() => _TafsirItemState();
}

class _TafsirItemState extends State<TafsirItem> {
  bool isVolumeUp = true;
  RecitersMoshaf? selectedSurah;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RadioProvider>();
    final isActive = provider.currentPlayingURL == widget.tafsir.url;

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
              widget.tafsir.name,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: AppTheme.black),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  provider.playTafsir(tafsir: widget.tafsir);
                },
                icon: Icon(
                  isActive && provider.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 45,
                  color: AppTheme.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (provider.currentPlayingURL == widget.tafsir.url) {
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
