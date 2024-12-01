import 'package:premium_filter/export.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => RestService(
        appBaseUrl: AppConstants.baseUrl,
        store: Get.find(),
        appBaseDevUrl: AppConstants.baseUrl,
        isDev: false,
      ));

  Get.lazyPut(() => PFRepo(
        store: Get.find(),
        apiClient: Get.find(),
      ));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController());
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => VehiclesController(localizationController: Get.find(), pfRepo: Get.find()));
  Get.lazyPut(() => FindController(localizationController: Get.find(), pfRepo: Get.find()));
  Get.lazyPut(() => RefController(localizationController: Get.find(), pfRepo: Get.find()));

  Map<String, Map<String, String>> languages = {};

  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = json;
  }
  return languages;
}
