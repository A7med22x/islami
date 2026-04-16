import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/provider/radio_provider.dart';
import 'package:provider/provider.dart';

class RadioItem extends StatefulWidget {
  const RadioItem({super.key, required this.name, required this.url});

  final String name;
  final String url;

  @override
  State<RadioItem> createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
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
              image: (provider.isPlaying && provider.currentPlayingURL == widget.url)
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
