
import 'package:hive_flutter/hive_flutter.dart';

class BookmarkLocalDataSource {
  static const String bookmarkBoxName = 'ayah_bookmarks';

  Future<Box> get _box async => Hive.openBox(bookmarkBoxName);

  String _key(int surahNumber, int ayahNumber) {
    return '${surahNumber}_$ayahNumber';
  }

  Future<void> toggleBookmark({
    required int surahNumber,
    required int ayahNumber,
    required String ayahText,
  }) async {
    final box = await _box;
    final key = _key(surahNumber, ayahNumber);

    if (box.containsKey(key)) {
      await box.delete(key);
    } else {
      await box.put(key, {
        'surahNumber': surahNumber,
        'ayahNumber': ayahNumber,
        'ayahText': ayahText,
      });
    }
  }

  Future<bool> isBookmarked({
    required int surahNumber,
    required int ayahNumber,
  }) async {
    final box = await _box;
    return box.containsKey(_key(surahNumber, ayahNumber));
  }

  Future<List<Map<String, dynamic>>> getBookmarks() async {
    final box = await _box;

    return box.values
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}