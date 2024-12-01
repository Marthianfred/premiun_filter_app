import 'package:premium_filter/export.dart';

class AppConstants {
  static const String appName = 'premium_filter';
  static const String appVersion = "v1.0.0";
  static const String appBar = 'premium_filter_appBar';

  static const String fontFamily = 'Arial';
  //urls
  static const String baseUrl = 'http://operatecnologias-001-site1.dtempurl.com/WCFPremiumFilters.asmx/';

  /// Shared Key
  static const String theme = 'premium_filter_theme';
  static const String token = 'premium_filter_token';
  static const String countryCode = 'premium_filter_country_code';
  static const String languageCode = 'premium_filter_language_code';

  static const String userCountryCode = 'premium_filter_user_country_code';


  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.english, languageName: 'Spanish', countryCode: 'CO', languageCode: 'es'),
    LanguageModel(imageUrl: Images.english, languageName: 'English', countryCode: 'US', languageCode: 'en'),
  ];
}
