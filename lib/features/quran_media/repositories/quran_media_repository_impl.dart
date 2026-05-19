
import 'package:dio/dio.dart';

import '../../../core/errors/failures.dart';
import '../data/quran_media_remote_data_source.dart';
import 'quran_media_repository.dart';

class QuranMediaRepositoryImpl implements QuranMediaRepository {
  final QuranMediaRemoteDataSource remote;

  QuranMediaRepositoryImpl({
    required this.remote,
  });

  @override
  Future<({Failure? failure, Map<String, dynamic>? data})> getSurahAudio({
    required int surahNumber,
    required String reciterEdition,
  }) async {
    try {
      final data = await remote.getSurahAudio(
        surahNumber: surahNumber,
        reciterEdition: reciterEdition,
      );

      return (
      failure: null as Failure?,
      data: data,
      );
    } on DioException {
      return (
      failure: const NetworkFailure('تعذر تحميل التلاوة الصوتية'),
      data: null as Map<String, dynamic>?,
      );
    } catch (_) {
      return (
      failure: const UnknownFailure('حدث خطأ غير متوقع'),
      data: null as Map<String, dynamic>?,
      );
    }
  }

  @override
  Future<({Failure? failure, Map<String, dynamic>? data})> getSurahMeaning({
    required int surahNumber,
    required String edition,
  }) async {
    try {
      final data = await remote.getSurahMeaning(
        surahNumber: surahNumber,
        edition: edition,
      );

      return (
      failure: null as Failure?,
      data: data,
      );
    } on DioException {
      return (
      failure: const NetworkFailure('تعذر تحميل المعنى أو التفسير'),
      data: null as Map<String, dynamic>?,
      );
    } catch (_) {
      return (
      failure: const UnknownFailure('حدث خطأ غير متوقع'),
      data: null as Map<String, dynamic>?,
      );
    }
  }

  @override
  Future<({Failure? failure, Map<String, dynamic>? data})> getAvailableTafsirEditions() async {
    try {
      final data = await remote.getAvailableTafsirEditions();

      return (
      failure: null as Failure?,
      data: data,
      );
    } on DioException {
      return (
      failure: const NetworkFailure('تعذر تحميل قائمة التفاسير'),
      data: null as Map<String, dynamic>?,
      );
    } catch (_) {
      return (
      failure: const UnknownFailure('حدث خطأ غير متوقع'),
      data: null as Map<String, dynamic>?,
      );
    }
  }
}