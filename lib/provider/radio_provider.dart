import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:islami/models/reciters_response/reciters_moshaf.dart';

class RadioProvider extends ChangeNotifier {
  final _player = AudioPlayer();
  String? currentPlayingURL;
  bool isPlaying = false;
  double currentVolume = 2.0;

  Future<void> play(String url) async {
    if (currentPlayingURL == url) {
      isPlaying ? await _player.pause() : _player.resume();
      isPlaying = !isPlaying;
    } else {
      await _player.stop();
      currentPlayingURL = url;
      await _player.play(UrlSource(url), volume: currentVolume);
      isPlaying = true;
    }
    notifyListeners();
  }

  Future<void> stop() async {
    await _player.stop();
    currentPlayingURL = null;
    isPlaying = false;
    notifyListeners();
  }

  Future<void> setVolume(double volume) async {
    currentVolume = volume;
    await _player.setVolume(volume);
    notifyListeners();
  }

  RecitersMoshaf? selectedReciter;

  void setSelectedReciter(RecitersMoshaf? reciter) {
    selectedReciter = reciter;
    notifyListeners();
  }

  String get surahCode {
    return selectedReciter?.code.toString().padLeft(3, '0') ?? "002";
  }
}
