import 'package:flutter/material.dart';
import 'package:islami/models/reciters_response/reciters_moshaf.dart';
import 'package:islami/models/tafasir/tafsir.dart';
import '../main.dart';

class RadioProvider extends ChangeNotifier {
  String? currentPlayingURL;
  bool isPlaying = false;
  double currentVolume = 1.0;
  bool isRadio = false;
  bool isTafsir = false;
  String? currentReciterName;
  RecitersMoshaf? currentSurah;
  List<RecitersMoshaf> currentPlaylist = [];
  String currentServer = "";
  int currentIndex = 0;
  String? currentRadioName;
  Tafsir? currentTafsir;

  RadioProvider() {
    audioHandler.currentIndexStream.listen((index) {
      if (index == null) return;

      if (index >= currentPlaylist.length) return;

      currentIndex = index;

      currentSurah = currentPlaylist[index];

      currentPlayingURL = "$currentServer${currentSurah!.code}.mp3";

      notifyListeners();
    });

    audioHandler.playerStateStream.listen((state) {
      if (isPlaying != state.playing) {
        isPlaying = state.playing;
        notifyListeners();
      }
    });
  }

  Future<void> play() async {
    await audioHandler.play();
  }

  Future<void> pause() async {
    await audioHandler.pause();
  }

  Future<void> nextSurah() async {
    if (!isRadio) {
      await audioHandler.skipToNext();
    }
  }

  Future<void> previousSurah() async {
    if (!isRadio) {
      await audioHandler.skipToPrevious();
    }
  }

  Future<void> playRadio({required String name, required String url}) async {
    final wasCurrent = currentPlayingURL == url;

    isRadio = true;
    isTafsir = false;
    currentPlayingURL = url;
    currentRadioName = name;

    if (wasCurrent) {
      if (isPlaying) {
        await audioHandler.pause();
      } else {
        await audioHandler.play();
      }
    } else {
      await audioHandler.playSingle(url: url);
    }

    notifyListeners();
  }

  Future<void> playTafsir({required Tafsir tafsir}) async {
    final wasCurrent = currentPlayingURL == tafsir.url;

    isRadio = false;
    isTafsir = true;

    currentTafsir = tafsir;
    currentPlayingURL = tafsir.url;

    if (wasCurrent) {
      if (isPlaying) {
        await audioHandler.pause();
        isPlaying = false;
      } else {
        await audioHandler.play();
        isPlaying = true;
      }
    } else {
      await audioHandler.playSingle(url: tafsir.url);
      isPlaying = true;
    }

    notifyListeners();
  }

  Future<void> playReciter({
    required String reciterName,
    required String server,
    required List<RecitersMoshaf> playlist,
    required int initialIndex,
  }) async {
    final selectedUrl = "$server${playlist[initialIndex].code}.mp3";

    final isSameSurah =
        currentPlayingURL == selectedUrl && currentReciterName == reciterName;

    if (isSameSurah) {
      if (isPlaying) {
        await audioHandler.pause();
      } else {
        await audioHandler.play();
      }

      return;
    }

    currentReciterName = reciterName;
    currentPlaylist = playlist;
    currentServer = server;
    currentIndex = initialIndex;
    currentSurah = playlist[initialIndex];
    currentPlayingURL = selectedUrl;
    isRadio = false;
    isTafsir = false;

    final urls = playlist.map((surah) => "$server${surah.code}.mp3").toList();

    await audioHandler.playQueue(urls: urls, initialIndex: initialIndex);

    notifyListeners();
  }

  Future<void> stop() async {
    await audioHandler.stop();

    currentPlayingURL = null;
    currentRadioName = null;
    currentTafsir = null;
    currentReciterName = null;
    currentSurah = null;
    currentPlaylist.clear();
    currentServer = "";
    currentIndex = 0;
    isPlaying = false;
    isRadio = false;
    isTafsir = false;

    notifyListeners();
  }

  Future<void> setVolume(double value) async {
    currentVolume = value;
    await audioHandler.setVolume(value);
    notifyListeners();
  }

  Future<void> toggleVolume() async {
    if (currentVolume == 0) {
      await setVolume(1.0);
    } else {
      await setVolume(0.0);
    }
  }
}
