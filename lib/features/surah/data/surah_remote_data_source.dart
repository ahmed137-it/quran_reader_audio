
import 'package:dio/dio.dart';

import '../../../core/api/api_constants.dart';
import '../models/surah_model.dart';

class SurahRemoteDataSource {
  final Dio dio;

  SurahRemoteDataSource(this.dio);

  Future<List<SurahModel>> getSurahs() async {
    final response = await dio.get(
      '${ApiConstants.quranApiBaseUrl}/surah.json',
    );

    final List list = response.data as List;

    return List<SurahModel>.generate(
      list.length,
          (index) {
        final json = Map<String, dynamic>.from(list[index]);

        return SurahModel.fromListJson({
          ...json,
          'number': index + 1,
        });
      },
    );
  }

  Future<SurahModel> getSurahByNumber(int surahNumber) async {
    final response = await dio.get(
      '${ApiConstants.quranApiBaseUrl}/$surahNumber.json',
    );

    final json = Map<String, dynamic>.from(response.data);

    return SurahModel.fromReaderJson(json);
  }
}

/*
import 'package:dio/dio.dart';

import '../../../core/api/api_constants.dart';
import '../models/surah_model.dart';

class SurahRemoteDataSource {
  final Dio dio;

  SurahRemoteDataSource(this.dio);

  Future<List<SurahModel>> getSurahs() async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}/surah.json',
    );

    final List list = response.data as List;

    return List<SurahModel>.generate(
      list.length,
          (index) {
        final json = Map<String, dynamic>.from(list[index]);

        return SurahModel.fromListJson({
          ...json,
          'number': index + 1,
        });
      },
    );
  }

  Future<SurahModel> getSurahByNumber(int surahNumber) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}/$surahNumber.json',
    );

    final json = Map<String, dynamic>.from(response.data);

    return SurahModel.fromReaderJson(json);
  }
}
*/