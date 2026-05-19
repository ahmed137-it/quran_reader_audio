
import 'ayah_model.dart';

class SurahModel {
  final int number;
  final String name;
  final String englishName;
  final String revelationType;
  final int numberOfAyahs;
  final List<AyahModel> ayahs;

  const SurahModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.revelationType,
    required this.numberOfAyahs,
    this.ayahs = const [],
  });

  factory SurahModel.fromListJson(Map<String, dynamic> json) {
    return SurahModel(
      number: json['number'] ?? json['surahNo'] ?? 0,

      // اسم السورة العربي
      name: json['surahNameArabicLong'] ??
          json['surahNameArabic'] ??
          json['name'] ??
          '',

      // الاسم الإنجليزي
      englishName: json['surahName'] ??
          json['englishName'] ??
          json['english_name'] ??
          '',

      // مكان النزول
      revelationType: json['revelationPlace'] ??
          json['revelationType'] ??
          json['type'] ??
          '',

      // عدد الآيات
      numberOfAyahs: json['totalAyah'] ??
          json['numberOfAyahs'] ??
          json['total_verses'] ??
          json['verses'] ??
          0,
    );
  }

  factory SurahModel.fromReaderJson(Map<String, dynamic> json) {
    final List arabicAyahs = json['arabic1'] ?? [];

    return SurahModel(
      number: json['surahNo'] ?? json['number'] ?? 0,
      name: json['surahNameArabicLong'] ??
          json['surahNameArabic'] ??
          json['name'] ??
          '',
      englishName: json['surahName'] ??
          json['englishName'] ??
          '',
      revelationType: json['revelationPlace'] ??
          json['revelationType'] ??
          '',
      numberOfAyahs: json['totalAyah'] ?? arabicAyahs.length,
      ayahs: List<AyahModel>.generate(
        arabicAyahs.length,
            (index) {
          return AyahModel(
            number: index + 1,
            numberInSurah: index + 1,
            text: arabicAyahs[index].toString(),
          );
        },
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'revelationType': revelationType,
      'numberOfAyahs': numberOfAyahs,
      'ayahs': ayahs.map((e) => e.toJson()).toList(),
    };
  }
}


/*
import 'ayah_model.dart';

class SurahModel {
  final int number;
  final String name;
  final String englishName;
  final String revelationType;
  final int numberOfAyahs;
  final List<AyahModel> ayahs;

  const SurahModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.revelationType,
    required this.numberOfAyahs,
    this.ayahs = const [],
  });

  factory SurahModel.fromListJson(Map<String, dynamic> json) {
    return SurahModel(
      number: json['number'] ?? json['id'] ?? 0,
      name: json['name'] ?? json['arabicName'] ?? '',
      englishName: json['englishName'] ?? json['english_name'] ?? '',
      revelationType: json['revelationType'] ?? json['type'] ?? '',
      numberOfAyahs: json['numberOfAyahs'] ?? json['total_verses'] ?? json['verses'] ?? 0,
    );
  }
  factory SurahModel.fromReaderJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = Map<String, dynamic>.from(
      json['data'] ?? json,
    );

    final List ayahsJson = data['ayahs'] ?? data['verses'] ?? [];

    return SurahModel(
      number: data['number'] ?? data['id'] ?? 0,
      name: data['name'] ?? data['arabicName'] ?? '',
      englishName: data['englishName'] ?? data['english_name'] ?? '',
      revelationType: data['revelationType'] ?? data['type'] ?? '',
      numberOfAyahs: data['numberOfAyahs'] ?? ayahsJson.length,
      ayahs: List<AyahModel>.from(
        ayahsJson.map(
              (e) => AyahModel.fromJson(Map<String, dynamic>.from(e)),
        ),
      ),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'revelationType': revelationType,
      'numberOfAyahs': numberOfAyahs,
      'ayahs': ayahs.map((e) => e.toJson()).toList(),
    };
  }
}
*/