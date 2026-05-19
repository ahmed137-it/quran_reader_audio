
import 'package:dio/dio.dart';

import '../../../core/api/api_constants.dart';

class QuranMediaRemoteDataSource {
  final Dio dio;

  QuranMediaRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> getSurahAudio({
    required int surahNumber,
    required String reciterEdition,
  }) async {
    final response = await dio.get(
      '${ApiConstants.alQuranCloudBaseUrl}/surah/$surahNumber/$reciterEdition',
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> getSurahMeaning({
    required int surahNumber,
    required String edition,
  }) async {
    final response = await dio.get(
      '${ApiConstants.alQuranCloudBaseUrl}/surah/$surahNumber/$edition',
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> getAvailableTafsirEditions() async {
    final response = await dio.get(
      '${ApiConstants.alQuranCloudBaseUrl}/edition/type/tafsir',
    );

    return Map<String, dynamic>.from(response.data);
  }
}

/*
import 'package:dio/dio.dart';
import '../../../core/api/api_constants.dart';

class QuranMediaRemoteDataSource {
  final Dio dio;

  QuranMediaRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> getSurahAudio({
    required int surahNumber,
    required String reciterEdition,
  }) async {
    final response = await dio.get(
      '${ApiConstants.alQuranCloudBaseUrl}/surah/$surahNumber/$reciterEdition',
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> getSurahMeaning({
    required int surahNumber,
    required String edition,
  }) async {
    final response = await dio.get(
      '${ApiConstants.alQuranCloudBaseUrl}/surah/$surahNumber/$edition',
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> getSurahWithMultipleEditions({
    required int surahNumber,
    required List<String> editions,
  }) async {
    final joined = editions.join(',');

    final response = await dio.get(
      '${ApiConstants.alQuranCloudBaseUrl}/surah/$surahNumber/editions/$joined',
    );

    return Map<String, dynamic>.from(response.data);
  }
}

*/