import 'package:just_audio/just_audio.dart';

class MyAudioHandler {
  final AudioPlayer _player = AudioPlayer();

  List<String> urls = [];

  Stream<Duration> get positionStream => _player.positionStream;

  Stream<Duration?> get durationStream => _player.durationStream;

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  Stream<int?> get currentIndexStream => _player.currentIndexStream;

  Future<void> playQueue({
    required List<String> urls,
    int initialIndex = 0,
  }) async {
    urls = urls;

    final sources = urls.map((url) => AudioSource.uri(Uri.parse(url))).toList();

    await _player.setAudioSources(sources, initialIndex: initialIndex);

    await _player.play();
  }

  Future<void> playSingle({required String url}) async {
    await playQueue(urls: [url], initialIndex: 0);
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Future<void> skipToNext() async {
    if (_player.hasNext) {
      await _player.seekToNext();
      await _player.play();
    }
  }

  Future<void> skipToPrevious() async {
    if (_player.hasPrevious) {
      await _player.seekToPrevious();
      await _player.play();
    }
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
