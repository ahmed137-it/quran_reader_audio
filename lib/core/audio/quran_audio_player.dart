
import 'package:just_audio/just_audio.dart';

class QuranAudioPlayer {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playSingleUrl(String url) async {
    await _player.stop();
    await _player.setUrl(url);
    await _player.play();
  }

  Future<void> playPlaylist(
      List<String> urls, {
        int startIndex = 0,
      }) async {
    if (urls.isEmpty) return;

    await _player.stop();

    final playlist = ConcatenatingAudioSource(
      children: urls.map((url) {
        return AudioSource.uri(Uri.parse(url));
      }).toList(),
    );

    await _player.setAudioSource(
      playlist,
      initialIndex: startIndex,
      initialPosition: Duration.zero,
    );

    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    await _player.play();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
/*
import 'package:just_audio/just_audio.dart';

class QuranAudioPlayer {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String url) async {
    await _player.stop();
    await _player.setUrl(url);
    await _player.play();
  }

  Future<void> playPlaylist(List<String> urls) async {
    if (urls.isEmpty) return;

    await _player.stop();

    final playlist = ConcatenatingAudioSource(
      children: urls.map((url) {
        return AudioSource.uri(Uri.parse(url));
      }).toList(),
    );

    await _player.setAudioSource(playlist);
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    await _player.play();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
*/
/*
import 'package:just_audio/just_audio.dart';

class QuranAudioPlayer {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String url) async {
    await _player.setUrl(url);
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }

  Future<void> playPlaylist(List<String> urls) async {
    final playlist = ConcatenatingAudioSource(
      children: urls.map((url) {
        return AudioSource.uri(Uri.parse(url));
      }).toList(),
    );

    await _player.setAudioSource(playlist);
    await _player.play();
  }
}
*/