

import '../api/api_constants.dart';

class ArabicNumbers {
  ArabicNumbers._();

  static String convert(num number) {
    return number.toString().split('').map((char) {
      final digit = int.tryParse(char);
      return digit == null ? char : ApiConstants.arabicNums[digit];
    }).join();
  }
}