import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/main.dart';
import 'package:islami/provider/radio_provider.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  String _format(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (h > 0) {
      return "$h:$m:$s";
    }
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RadioProvider>();

    if (provider.currentPlayingURL == null) {
      return const SizedBox.shrink();
    }

    return StreamBuilder<Duration>(
      stream: audioHandler.positionStream,
      builder: (context, posSnap) {
        final position = posSnap.data ?? Duration.zero;
        return StreamBuilder<Duration?>(
          stream: audioHandler.durationStream,
          builder: (context, durSnap) {
            final duration = durSnap.data ?? Duration.zero;
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppTheme.primary, width: 1),
                borderRadius: BorderRadius.circular(24),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Text(
                    provider.isRadio
                        ? provider.currentRadioName ?? "Live Radio"
                        : provider.isTafsir
                        ? provider.currentTafsir?.name ?? ""
                        : "${provider.currentReciterName ?? ""} - ${provider.currentSurah?.name ?? ""}",
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontSize: 18,
                    ),
                  ),
                  if (!provider.isRadio)
                    Slider(
                      value: position.inSeconds
                          .clamp(
                            0,
                            duration.inSeconds == 0 ? 1 : duration.inSeconds,
                          )
                          .toDouble(),
                      max: (duration.inSeconds == 0 ? 1 : duration.inSeconds)
                          .toDouble(),
                      onChanged: (value) {
                        audioHandler.seek(Duration(seconds: value.toInt()));
                      },
                    ),
                  if (!provider.isRadio)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _format(position),
                          style: const TextStyle(color: AppTheme.primary),
                        ),
                        Text(
                          _format(duration),
                          style: const TextStyle(color: AppTheme.primary),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: provider.isRadio
                            ? null
                            : provider.previousSurah,
                        icon: const Icon(Icons.skip_previous, size: 24),
                        color: AppTheme.primary,
                      ),
                      IconButton(
                        onPressed: () {
                          if (provider.isPlaying) {
                            provider.pause();
                          } else {
                            provider.play();
                          }
                        },
                        icon: Icon(
                          provider.isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 24,
                        ),
                        color: AppTheme.primary,
                      ),
                      IconButton(
                        onPressed: provider.stop,
                        icon: const Icon(Icons.stop, size: 24),
                        color: AppTheme.primary,
                      ),
                      IconButton(
                        onPressed: provider.toggleVolume,
                        icon: Icon(
                          provider.currentVolume == 0
                              ? Icons.volume_off
                              : Icons.volume_up,
                          color: AppTheme.primary,
                          size: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: provider.isRadio ? null : provider.nextSurah,
                        icon: const Icon(Icons.skip_next, size: 24),
                        color: AppTheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
