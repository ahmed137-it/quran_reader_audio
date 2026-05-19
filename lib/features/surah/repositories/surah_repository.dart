
import '../../../core/errors/failures.dart';
import '../models/surah_model.dart';

abstract class SurahRepository {
  Future<({Failure? failure, List<SurahModel>? data})> getSurahs();

  Future<({Failure? failure, SurahModel? data})> getSurahByNumber(int surahNumber);
}