
class AyahModel {
  final int number;
  final int numberInSurah;
  final String text;

  const AyahModel({
    required this.number,
    required this.numberInSurah,
    required this.text,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'] ?? json['id'] ?? 0,
      numberInSurah: json['numberInSurah'] ?? json['verse'] ?? json['number'] ?? 0,
      text: json['text'] ?? json['arabic_text'] ?? json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'numberInSurah': numberInSurah,
      'text': text,
    };
  }
}

/*
class AyahModel {
  final int number;
  final int numberInSurah;
  final String text;

  const AyahModel({
    required this.number,
    required this.numberInSurah,
    required this.text,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'] ?? json['id'] ?? 0,
      numberInSurah: json['numberInSurah'] ?? json['verse'] ?? json['number'] ?? 0,
      text: json['text'] ?? json['arabic_text'] ?? json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'numberInSurah': numberInSurah,
      'text': text,
    };
  }
}
*/