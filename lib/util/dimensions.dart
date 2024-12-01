import 'package:get/get.dart';

class Dimensions {
  static double fontSizeOverSmall = Get.context!.width >= 1300 ? 12 : 10;
  static double fontSizeExtraSmall = Get.context!.width >= 1300 ? 14 : 12;
  static double fontSizeSmall = Get.context!.width >= 1300 ? 16 : 14;
  static double fontSizeDefault = Get.context!.width >= 1300 ? 18 : 16;
  static double fontSizeLarge = Get.context!.width >= 1300 ? 20 : 18;
  static double fontSizeExtraLarge = Get.context!.width >= 1300 ? 24 : 20;
  static double fontSizeOverLarge = Get.context!.width >= 1300 ? 26 : 24;
  static double fontSizeOverExtraLarge = Get.context!.width >= 1300 ? 40 : 32;

  static const double paddingSizeBtn = 6.0;
  static const double paddingSizeExtraSmall = 8.0;
  static const double paddingSizeSmall = 12.0;
  static const double paddingTopDefault = 32.0;
  static const double paddingBottomDefault = 32.0;
  static const double paddingSizeDefault = 16.0;
  static const double paddingSizeLarge = 24.0;
  static const double paddingSizeExtraLarge = 25.0;
  static const double paddingSizeExtremeLarge = 30.0;

  static const double radiusSmall = 4.0;
  static const double radiusDefault = 8.0;
  static const double radiusLarge = 16.0;
  static const double radiusExtraLarge = 20.0;

  static const double webMaxWidth = 1170;
  static const int messageInputLength = 250;


  static const double defaultIconSize = 24;
}
