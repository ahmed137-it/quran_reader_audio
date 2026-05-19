

//--quran_app1/core/api/api_constants.dart
class ApiConstants {
  ApiConstants._();

  // QuranAPI للعرض وقائمة السور
  static const String quranApiBaseUrl = 'https://quranapi.pages.dev/api';
  static const String baseUrl = quranApiBaseUrl;

  // AlQuran Cloud للأصوات والمعاني والتفاسير
  static const String alQuranCloudBaseUrl = 'https://api.alquran.cloud/v1';

  static const List<String> arabicNums = [
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
  ];
 /* static const List<String> arabicNums = [
    '٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'
  ];*/

  static const Map<String, String> recitersAr = {
    'ar.minshawi': 'محمد صديق المنشاوي',
    'ar.minshawimujawwad': 'محمد صديق المنشاوي - المجود',
    'ar.abdulsamad': 'عبد الباسط عبد الصمد',
    'ar.abdulbasitmurattal': 'عبد الباسط عبد الصمد - المرتل',
    'ar.alafasy': 'مشاري راشد العفاسي',
    'ar.husary': 'محمود خليل الحصري',
    'ar.mahermuaiqly': 'ماهر المعيقلي',
    'ar.abdurrahmaansudais': 'عبد الرحمن السديس',
    'ar.hudhaify': 'علي الحذيفي',
    'ar.shaatree': 'أبو بكر الشاطري',
    'ar.hanirifai': 'هاني الرفاعي',
  };

  static const Map<String, String> meaningEditions = {
    'ar.muyassar': 'العربية - المعنى الميسر',
    'en.sahih': 'English - Saheeh International',
    'en.pickthall': 'English - Pickthall',
    'en.yusufali': 'English - Yusuf Ali',
    'ur.junagarhi': 'اردو - جوناگڑھی',
    'bn.bengali': 'বাংলা - Muhiuddin Khan',
    'fr.hamidullah': 'Français - Hamidullah',
    'id.indonesian': 'Indonesia',
    'fa.fooladvand': 'فارسی - فولادوند',
  };

  static const Map<String, String> tafsirEditionsAr = {
    'ar.muyassar': 'التفسير الميسر',
    'ar.jalalayn': 'تفسير الجلالين',
    'ar.qurtubi': 'تفسير القرطبي',
    'ar.waseet': 'التفسير الوسيط',
    'ar.baghawi': 'تفسير البغوي',
  };
}