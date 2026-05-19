import 'package:dio/dio.dart';

import '../../../core/errors/failures.dart';
import '../data/surah_local_data_source.dart';
import '../data/surah_remote_data_source.dart';
import '../models/surah_model.dart';
import 'surah_repository.dart';

class SurahRepositoryImpl implements SurahRepository {
  final SurahRemoteDataSource remote;
  final SurahLocalDataSource local;

  SurahRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<({Failure? failure, List<SurahModel>? data})> getSurahs() async {
    try {
      final List<SurahModel> surahs = await remote.getSurahs();

      await local.cacheSurahList(surahs);

      return (
      failure: null as Failure?,
      data: surahs,
      );
    } on DioException {
      final List<SurahModel> cached = await local.getCachedSurahList();

      if (cached.isNotEmpty) {
        return (
        failure: null as Failure?,
        data: cached,
        );
      }

      return (
      failure: const NetworkFailure('تعذر الاتصال بالخادم'),
      data: null as List<SurahModel>?,
      );
    } catch (_) {
      return (
      failure: const UnknownFailure('حدث خطأ غير متوقع'),
      data: null as List<SurahModel>?,
      );
    }
  }

  @override
  Future<({Failure? failure, SurahModel? data})> getSurahByNumber(
      int surahNumber,
      ) async {
    try {
      final SurahModel surah = await remote.getSurahByNumber(surahNumber);

      await local.cacheSurah(surah);

      return (
      failure: null as Failure?,
      data: surah,
      );
    } on DioException {
      final SurahModel? cached = await local.getCachedSurah(surahNumber);

      if (cached != null) {
        return (
        failure: null as Failure?,
        data: cached,
        );
      }

      return (
      failure:  NetworkFailure('تعذر تحميل السورة'),
      data: null as SurahModel?,
      );
    } catch (_) {
      return (
      failure:  UnknownFailure('حدث خطأ غير متوقع'),
      data: null as SurahModel?,
      );
    }
  }
}