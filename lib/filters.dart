import 'package:premium_filter/export.dart';

class FiltersAPP extends StatelessWidget {
  final NotificationBody? body;
  final Map<String, Map<String, String>>? languages;
  final SharedPreferences prefs;

  const FiltersAPP({
    super.key,
    required this.languages,
    required this.body,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return GetBuilder<SplashController>(builder: (splashController) {
            return GetBuilder<VehiclesController>(builder: (vehiclesController) {
              return GetBuilder<FindController>(builder: (findController) {
                return GetMaterialApp(
                  title: AppConstants.appName,
                  debugShowCheckedModeBanner: false,
                  navigatorKey: Get.key,
                  scrollBehavior: const MaterialScrollBehavior().copyWith(
                    dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
                  ),
                  theme: themeController.darkTheme ? light() : light(),
                  themeMode: ThemeMode.light,
                  locale: localizeController.locale,
                  translations: Messages(languages: languages),
                  fallbackLocale: Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode),
                  initialRoute: RouteHelper.getSplashRoute(body),
                  getPages: RouteHelper.routes,
                  builder: (BuildContext context, widget) {
                    return Overlay(
                      initialEntries: [
                        OverlayEntry(builder: (context) {
                          return MediaQuery(
                              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
                              child: Scaffold(
                                resizeToAvoidBottomInset: false,
                                backgroundColor: colorBackground,
                                body: Stack(children: [
                                  widget!,
                                ]),
                              ));
                        })
                      ],
                    );
                  },
                );
              });
            });
          });
        });
      });
    });
  }
}
