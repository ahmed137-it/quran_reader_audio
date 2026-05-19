

import 'package:hive_flutter/hive_flutter.dart';
import '../models/surah_model.dart';

class SurahLocalDataSource {
  static const String surahBoxName = 'surah_box';
  static const String surahListKey = 'surah_list';

  Future<Box> get _box async => Hive.openBox(surahBoxName);

  Future<void> cacheSurahList(List<SurahModel> surahs) async {
    final box = await _box;
    await box.put(
      surahListKey,
      surahs.map((e) => e.toJson()).toList(),
    );
  }

  Future<List<SurahModel>> getCachedSurahList() async {
    final box = await _box;
    final data = box.get(surahListKey);

    if (data == null) return [];

    return List<SurahModel>.from(
      (data as List).map((e) => SurahModel.fromListJson(Map<String, dynamic>.from(e))),
    );
  }

  Future<void> cacheSurah(SurahModel surah) async {
    final box = await _box;
    await box.put('surah_${surah.number}', surah.toJson());
  }

  Future<SurahModel?> getCachedSurah(int surahNumber) async {
    final box = await _box;
    final data = box.get('surah_$surahNumber');

    if (data == null) return null;

    return SurahModel.fromReaderJson(Map<String, dynamic>.from(data));
  }
}