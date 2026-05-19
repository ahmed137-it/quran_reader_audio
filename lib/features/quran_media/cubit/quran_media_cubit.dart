
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/audio/quran_audio_player.dart';
import '../../../core/errors/failures.dart';
import '../repositories/quran_media_repository.dart';
import 'quran_media_state.dart';

class QuranMediaCubit extends Cubit<QuranMediaState> {
  final QuranMediaRepository repository;
  final QuranAudioPlayer audioPlayer;

  QuranMediaCubit({
    required this.repository,
    required this.audioPlayer,
  }) : super(const QuranMediaState());

  // =========================
  // Audio
  // =========================

  Future<void> loadAudio({
    required int surahNumber,
    required String reciter,
  }) async {
    emit(
      state.copyWith(
        status: QuranMediaStatus.loading,
        selectedReciter: reciter,
        audioUrls: [],
        ayahsText: [],
        errorMessage: null,
      ),
    );

    final result = await repository.getSurahAudio(
      surahNumber: surahNumber,
      reciterEdition: reciter,
    );

    if (result.failure != null) {
      emit(
        state.copyWith(
          status: QuranMediaStatus.failure,
          errorMessage: result.failure!.message,
        ),
      );
      return;
    }

    final data = result.data?['data'];
    final ayahs = data?['ayahs'];

    final List<String> audioUrls = [];

    if (ayahs is List) {
      for (final item in ayahs) {
        final ayah = Map<String, dynamic>.from(item);

        final audio = ayah['audio'];

        if (audio != null && audio.toString().trim().isNotEmpty) {
          audioUrls.add(audio.toString());
          continue;
        }

        final audioSecondary = ayah['audioSecondary'];

        if (audioSecondary is List && audioSecondary.isNotEmpty) {
          final firstSecondary = audioSecondary.first;

          if (firstSecondary != null &&
              firstSecondary.toString().trim().isNotEmpty) {
            audioUrls.add(firstSecondary.toString());
          }
        }
      }
    }

    if (audioUrls.isEmpty) {
      emit(
        state.copyWith(
          status: QuranMediaStatus.failure,
          rawData: result.data,
          errorMessage: 'لم يتم العثور على روابط صوتية لهذا القارئ',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: QuranMediaStatus.success,
        rawData: result.data,
        audioUrls: audioUrls,
        errorMessage: null,
      ),
    );
  }

  Future<void> playFullSurahAudio() async {
    if (!_hasAudioUrls()) return;

    await audioPlayer.playPlaylist(state.audioUrls);
  }

  Future<void> playAyahAudio(int ayahNumber) async {
    if (!_hasAudioUrls()) return;

    final index = ayahNumber - 1;

    if (index < 0 || index >= state.audioUrls.length) {
      _emitAudioError('رقم الآية غير صحيح');
      return;
    }

    await audioPlayer.playSingleUrl(state.audioUrls[index]);
  }

  Future<void> playFromAyahToEnd(int ayahNumber) async {
    if (!_hasAudioUrls()) return;

    final startIndex = ayahNumber - 1;

    if (startIndex < 0 || startIndex >= state.audioUrls.length) {
      _emitAudioError('رقم الآية غير صحيح');
      return;
    }

    await audioPlayer.playPlaylist(
      state.audioUrls,
      startIndex: startIndex,
    );
  }

  Future<void> playAyahRange({
    required int fromAyah,
    required int toAyah,
  }) async {
    if (!_hasAudioUrls()) return;

    if (fromAyah <= 0 || toAyah <= 0 || fromAyah > toAyah) {
      _emitAudioError('نطاق الآيات غير صحيح');
      return;
    }

    final fromIndex = fromAyah - 1;
    final toIndex = toAyah - 1;

    if (fromIndex >= state.audioUrls.length ||
        toIndex >= state.audioUrls.length) {
      _emitAudioError('نطاق الآيات خارج عدد آيات السورة');
      return;
    }

    final selectedUrls = state.audioUrls.sublist(
      fromIndex,
      toIndex + 1,
    );

    await audioPlayer.playPlaylist(selectedUrls);
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> resumeAudio() async {
    await audioPlayer.resume();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  bool _hasAudioUrls() {
    if (state.audioUrls.isNotEmpty) return true;

    _emitAudioError('اختر القارئ أولًا لتحميل الصوت');
    return false;
  }

  void _emitAudioError(String message) {
    emit(
      state.copyWith(
        status: QuranMediaStatus.failure,
        errorMessage: message,
      ),
    );
  }

  // =========================
  // Meanings & Tafsir
  // =========================

  Future<void> loadMeaning({
    required int surahNumber,
    required String edition,
  }) async {
    emit(
      state.copyWith(
        status: QuranMediaStatus.loading,
        selectedMeaningEdition: edition,
        ayahsText: [],
        errorMessage: null,
      ),
    );

    final result = await repository.getSurahMeaning(
      surahNumber: surahNumber,
      edition: edition,
    );

    _handleTextResult(result);
  }

  Future<void> loadTafsir({
    required int surahNumber,
    required String edition,
  }) async {
    emit(
      state.copyWith(
        status: QuranMediaStatus.loading,
        selectedTafsirEdition: edition,
        ayahsText: [],
        errorMessage: null,
      ),
    );

    final result = await repository.getSurahMeaning(
      surahNumber: surahNumber,
      edition: edition,
    );

    _handleTextResult(result);
  }

  void _handleTextResult(
      ({Failure? failure, Map<String, dynamic>? data}) result,
      ) {
    if (result.failure != null) {
      emit(
        state.copyWith(
          status: QuranMediaStatus.failure,
          errorMessage: result.failure!.message,
        ),
      );
      return;
    }

    final data = result.data?['data'];
    final ayahs = data?['ayahs'];

    final List<String> texts = [];

    if (ayahs is List) {
      for (final item in ayahs) {
        final ayah = Map<String, dynamic>.from(item);
        final text = ayah['text'];

        if (text != null && text.toString().trim().isNotEmpty) {
          texts.add(text.toString());
        }
      }
    }

    emit(
      state.copyWith(
        status: QuranMediaStatus.success,
        rawData: result.data,
        ayahsText: texts,
        errorMessage: null,
      ),
    );
  }

  @override
  Future<void> close() async {
    await audioPlayer.dispose();
    return super.close();
  }
}

/*
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/audio/quran_audio_player.dart';
import '../../../core/errors/failures.dart';
import '../repositories/quran_media_repository.dart';
import 'quran_media_state.dart';

class QuranMediaCubit extends Cubit<QuranMediaState> {
  final QuranMediaRepository repository;
  final QuranAudioPlayer audioPlayer;

  QuranMediaCubit({
    required this.repository,
    required this.audioPlayer,
  }) : super(const QuranMediaState());

  Future<void> loadAudio({
    required int surahNumber,
    required String reciter,
  }) async {
    emit(
      state.copyWith(
        status: QuranMediaStatus.loading,
        selectedReciter: reciter,
        audioUrls: [],
        ayahsText: [],
      ),
    );

    final result = await repository.getSurahAudio(
      surahNumber: surahNumber,
      reciterEdition: reciter,
    );

    if (result.failure != null) {
      emit(
        state.copyWith(
          status: QuranMediaStatus.failure,
          errorMessage: result.failure!.message,
        ),
      );
      return;
    }

    final data = result.data?['data'];
    final ayahs = data?['ayahs'];

    final List<String> audioUrls = [];

    if (ayahs is List) {
      for (final item in ayahs) {
        final ayah = Map<String, dynamic>.from(item);

        final audio = ayah['audio'];

        if (audio != null && audio.toString().trim().isNotEmpty) {
          audioUrls.add(audio.toString());
          continue;
        }

        final audioSecondary = ayah['audioSecondary'];

        if (audioSecondary is List && audioSecondary.isNotEmpty) {
          final firstSecondary = audioSecondary.first;

          if (firstSecondary != null &&
              firstSecondary.toString().trim().isNotEmpty) {
            audioUrls.add(firstSecondary.toString());
          }
        }
      }
    }

    if (audioUrls.isEmpty) {
      emit(
        state.copyWith(
          status: QuranMediaStatus.failure,
          errorMessage: 'لم يتم العثور على روابط صوتية لهذا القارئ',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: QuranMediaStatus.success,
        rawData: result.data,
        audioUrls: audioUrls,
      ),
    );
  }

  Future<void> loadMeaning({
    required int surahNumber,
    required String edition,
  }) async {
    emit(
      state.copyWith(
        status: QuranMediaStatus.loading,
        selectedMeaningEdition: edition,
        ayahsText: [],
      ),
    );

    final result = await repository.getSurahMeaning(
      surahNumber: surahNumber,
      edition: edition,
    );

    _handleTextResult(result);
  }

  Future<void> loadTafsir({
    required int surahNumber,
    required String edition,
  }) async {
    emit(
      state.copyWith(
        status: QuranMediaStatus.loading,
        selectedTafsirEdition: edition,
        ayahsText: [],
      ),
    );

    final result = await repository.getSurahMeaning(
      surahNumber: surahNumber,
      edition: edition,
    );

    _handleTextResult(result);
  }

  void _handleTextResult(
      ({Failure? failure, Map<String, dynamic>? data}) result,
      ) {
    if (result.failure != null) {
      emit(
        state.copyWith(
          status: QuranMediaStatus.failure,
          errorMessage: result.failure!.message,
        ),
      );
      return;
    }

    final data = result.data?['data'];
    final ayahs = data?['ayahs'];

    final List<String> texts = [];

    if (ayahs is List) {
      for (final item in ayahs) {
        final ayah = Map<String, dynamic>.from(item);
        final text = ayah['text'];

        if (text != null && text.toString().trim().isNotEmpty) {
          texts.add(text.toString());
        }
      }
    }

    emit(
      state.copyWith(
        status: QuranMediaStatus.success,
        rawData: result.data,
        ayahsText: texts,
      ),
    );
  }
  Future<void> playFullSurahAudio() async {
    if (state.audioUrls.isEmpty) {
      emit(
        state.copyWith(
          status: QuranMediaStatus.failure,
          errorMessage: 'اختر القارئ أولًا لتحميل الصوت',
        ),
      );
      return;
    }

    await audioPlayer.playPlaylist(state.audioUrls);
  }


  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> resumeAudio() async {
    await audioPlayer.resume();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  @override
  Future<void> close() async {
    await audioPlayer.dispose();
    return super.close();
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/audio/quran_audio_player.dart';
import '../repositories/quran_media_repository.dart';
import 'quran_media_state.dart';

class QuranMediaCubit extends Cubit<QuranMediaState> {
  final QuranMediaRepository repository;
  final QuranAudioPlayer audioPlayer;

  QuranMediaCubit({
    required this.repository,
    required this.audioPlayer,
  }) : super(const QuranMediaState());

  Future<void> loadAudio({
    required int surahNumber,
    required String reciter,
  }) async {
    emit(
      state.copyWith(
        status: QuranMediaStatus.loading,
        selectedReciter: reciter,
        audioUrls: [],
        ayahsText: [],
      ),
    );

    final result = await repository.getSurahAudio(
      surahNumber: surahNumber,
      reciterEdition: reciter,
    );

    if (result.failure != null) {
      emit(
        state.copyWith(
          status: QuranMediaStatus.failure,
          errorMessage: result.failure!.message,
        ),
      );
      return;
    }

    final data = result.data?['data'];
    final ayahs = data?['ayahs'];

    final List<String> audioUrls = [];

    if (ayahs is List) {
      for (final ayah in ayahs) {
        final audio = ayah['audio'];
        if (audio != null && audio.toString().isNotEmpty) {
          audioUrls.add(audio.toString());
        }
      }
    }

    emit(
      state.copyWith(
        status: QuranMediaStatus.success,
        rawData: result.data,
        audioUrls: audioUrls,
      ),
    );
  }

  Future<void> loadMeaning({
    required int surahNumber,
    required String edition,
  }) async {
    emit(
      state.copyWith(
        status: QuranMediaStatus.loading,
        selectedMeaningEdition: edition,
        ayahsText: [],
      ),
    );

    final result = await repository.getSurahMeaning(
      surahNumber: surahNumber,
      edition: edition,
    );

    _handleTextResult(result);
  }

  Future<void> loadTafsir({
    required int surahNumber,
    required String edition,
  }) async {
    emit(
      state.copyWith(
        status: QuranMediaStatus.loading,
        selectedTafsirEdition: edition,
        ayahsText: [],
      ),
    );

    final result = await repository.getSurahMeaning(
      surahNumber: surahNumber,
      edition: edition,
    );

    _handleTextResult(result);
  }

  void _handleTextResult(
      ({dynamic failure, Map<String, dynamic>? data}) result,
      ) {
    if (result.failure != null) {
      emit(
        state.copyWith(
          status: QuranMediaStatus.failure,
          errorMessage: result.failure!.message,
        ),
      );
      return;
    }

    final data = result.data?['data'];
    final ayahs = data?['ayahs'];

    final List<String> texts = [];

    if (ayahs is List) {
      for (final ayah in ayahs) {
        final text = ayah['text'];
        if (text != null && text.toString().isNotEmpty) {
          texts.add(text.toString());
        }
      }
    }

    emit(
      state.copyWith(
        status: QuranMediaStatus.success,
        rawData: result.data,
        ayahsText: texts,
      ),
    );
  }

  Future<void> playFirstAyahAudio() async {
    if (state.audioUrls.isEmpty) return;
    await audioPlayer.play(state.audioUrls.first);
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  @override
  Future<void> close() async {
    await audioPlayer.dispose();
    return super.close();
  }

  Future<void> playFullSurahAudio() async {
    if (state.audioUrls.isEmpty) return;
    await audioPlayer.playPlaylist(state.audioUrls);
  }
}
*/