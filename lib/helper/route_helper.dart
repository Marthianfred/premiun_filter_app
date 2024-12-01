import 'package:premium_filter/export.dart';

class RouteHelper {
  static const String initial = '/';
  static const String language = '/language';
  static const String splash = '/splash';
  static const String update = '/update';
  static const String dashboard = '/dashboard';
  static const String error = '/error';
  static const String contact = '/contact';
  static const String favorites = '/favorites';
  static const String vehicle = '/vehicle';
  static const String noConnection = '/noConnection';
  static const String findProducts = '/find-products';
  static const String singleProducts = '/sigle-products';
  static const String refPremium = '/ref-premium';

  static String getInitialRoute({bool fromSplash = false}) => '$initial?from-splash=$fromSplash';

  static String getSplashRoute(NotificationBody? body) {
    String data = 'null';
    if (body != null) {
      List<int> encoded = utf8.encode(jsonEncode(body.toJson()));
      data = base64Encode(encoded);
    }
    return '$splash?data=$data';
  }

  static String getUpdateRoute(bool isUpdate) => '$update?update=${isUpdate.toString()}';
  static String getDashboardRoute() => dashboard;
  static String getLanguageRoute() => language;
  static String getFavoritesRoute() => favorites;
  static String getErrorRoute() => error;
  static String getContactRoute() => contact;
  static String getVehicleRoute() => vehicle;
  static String getNoConnectionRoute() => noConnection;
  static String getFindProductsRoute() => findProducts;
  static String getSingleProductRoute() => singleProducts;
  static String getRefPremiumRoute() => refPremium;

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      popGesture: false,
      page: () {
        NotificationBody? data;
        if (Get.parameters['data'] != 'null') {
          List<int> decode = base64Decode(Get.parameters['data']!.replaceAll(' ', '+'));
          data = NotificationBody.fromJson(jsonDecode(utf8.decode(decode)));
        }
        return SplashScreen(body: data);
      },
    ),
    GetPage(
      name: update,
      popGesture: true,
      page: () => MainUpdateScreen(isUpdate: Get.parameters['update'] == 'true'),
    ),
    GetPage(
      name: language,
      popGesture: true,
      page: () => const MainLanguageScreen(),
    ),
    GetPage(
      name: dashboard,
      popGesture: true,
      page: () => const MainDashboardScreen(),
    ),
    GetPage(
      name: contact,
      popGesture: true,
      page: () => const MainContactScreen(),
    ),
    GetPage(
      name: favorites,
      popGesture: true,
      page: () => const MainFavoritesSreen(),
    ),
    GetPage(
      name: vehicle,
      popGesture: true,
      page: () => const MainVehicleScreen(),
    ),
    GetPage(
      name: noConnection,
      popGesture: false,
      page: () => const MainNoConnectionScreen(),
    ),
    GetPage(
      name: findProducts,
      popGesture: true,
      page: () => const MainFindProductsWidget(),
    ),
    GetPage(
      name: singleProducts,
      popGesture: true,
      page: () => const SingleProductWidget(),
    ),
    GetPage(
      name: refPremium,
      popGesture: true,
      page: () => const MainRefPremiumWidget(),
    ),
  ];

  static Widget getRoute(Widget navigateTo, {bool byPuss = false}) {
    return navigateTo;
  }
}
