import 'package:premium_filter/export.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences);
  Get.put(RestService(
    appBaseUrl: AppConstants.baseUrl,
    store: Get.find(),
    appBaseDevUrl: AppConstants.baseUrl,
    isDev: false,
  ));

  Get.put(PFRepo(
    store: Get.find(),
    apiClient: Get.find(),
  ));

  // Controller
  Get.put(
    ThemeController(
      sharedPreferences: Get.find(),
    ),
  );
  Get.put(SplashController());
  Get.put(RefreshController());
  Get.put(LocalizationController(
    sharedPreferences: Get.find(),
    apiClient: Get.find(),
  ));
  Get.put(VehiclesController(
    localizationController: Get.find(),
    pfRepo: Get.find(),
  ));
  Get.put(FindController(
    localizationController: Get.find(),
    pfRepo: Get.find(),
  ));
  Get.put(RefController(
    localizationController: Get.find(),
    pfRepo: Get.find(),
  ));

  Map<String, Map<String, String>> languages = {};

  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
