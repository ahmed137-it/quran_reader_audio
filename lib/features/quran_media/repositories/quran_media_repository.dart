
import '../../../core/errors/failures.dart';

abstract class QuranMediaRepository {
  Future<({Failure? failure, Map<String, dynamic>? data})> getSurahAudio({
    required int surahNumber,
    required String reciterEdition,
  });

  Future<({Failure? failure, Map<String, dynamic>? data})> getSurahMeaning({
    required int surahNumber,
    required String edition,
  });

  Future<({Failure? failure, Map<String, dynamic>? data})> getAvailableTafsirEditions();
}

