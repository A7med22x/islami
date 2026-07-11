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
        final isActive = provider.currentPlayingURL == widget.url;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      provider.playRadio(name: widget.name, url: widget.url);
                    },
                    icon: Icon(
                      isActive && provider.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow_rounded,
                      size: 50,
                      color: AppTheme.black,
                    ),
                  ),
                  IconButton(
                    onPressed: isActive ? provider.stop : null,
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
      },
    );
  }
}
