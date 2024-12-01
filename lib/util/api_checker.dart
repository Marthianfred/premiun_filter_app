import 'package:premium_filter/export.dart';

class ApiChecker {
  static Future<void> checkApi(Response response) async {
    switch (response.statusCode) {
      case 1:
        Get.find<RestService>().cancelAllRequests();
        Get.find<SplashController>().hasConnection.value = false;
        Get.offAllNamed(RouteHelper.getNoConnectionRoute());
        break;

      default:
        if(kDebugMode) print(response.statusCode);
        break;
    }
  }
}
