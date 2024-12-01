import 'package:premium_filter/export.dart';

final oswaldRegular = GoogleFonts.oswald(
  fontWeight: FontWeight.w400,
  fontSize: MediaQuery.of(Get.context as BuildContext).size.width <= 400 ? Dimensions.fontSizeSmall : Dimensions.fontSizeDefault,
  color: colorTextPrimary,
);

final oswaldMedium = GoogleFonts.oswald(
  fontWeight: FontWeight.w500,
  fontSize: MediaQuery.of(Get.context as BuildContext).size.width <= 400 ? Dimensions.fontSizeSmall : Dimensions.fontSizeDefault,
  color: colorTextPrimary,
);
final oswaldBold = GoogleFonts.oswald(
  fontWeight: FontWeight.w700,
  fontSize: MediaQuery.of(Get.context as BuildContext).size.width <= 400 ? Dimensions.fontSizeSmall : Dimensions.fontSizeDefault,
  color: colorTextPrimary,
);
final oswaldBlack = GoogleFonts.oswald(
  fontWeight: FontWeight.w900,
  fontSize: MediaQuery.of(Get.context as BuildContext).size.width <= 400 ? Dimensions.fontSizeSmall : Dimensions.fontSizeDefault,
  color: colorTextPrimary,
);

final nunitoRegular = GoogleFonts.nunito(
  fontWeight: FontWeight.w400,
  fontSize: MediaQuery.of(Get.context as BuildContext).size.width <= 400 ? Dimensions.fontSizeSmall : Dimensions.fontSizeDefault,
  color: colorTextPrimary,
);

final nunitoMedium = GoogleFonts.nunito(
  fontWeight: FontWeight.w500,
  fontSize: MediaQuery.of(Get.context as BuildContext).size.width <= 400 ? Dimensions.fontSizeSmall : Dimensions.fontSizeDefault,
  color: colorTextPrimary,
);
final nunitoBold = GoogleFonts.nunito(
  fontWeight: FontWeight.w700,
  fontSize: MediaQuery.of(Get.context as BuildContext).size.width <= 400 ? Dimensions.fontSizeSmall : Dimensions.fontSizeDefault,
  color: colorTextPrimary,
);
final nunitoBlack = GoogleFonts.nunito(
  fontWeight: FontWeight.w900,
  fontSize: MediaQuery.of(Get.context as BuildContext).size.width <= 400 ? Dimensions.fontSizeSmall : Dimensions.fontSizeDefault,
  color: colorTextPrimary,
);



final BoxDecoration riderContainerDecoration = BoxDecoration(
  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
  color: Theme.of(Get.context!).primaryColor.withOpacity(0.1),
  shape: BoxShape.rectangle,
);

const colorPrimary = Color(0xFF001f31);
const colorSecondary = Color(0xFF404040);
const colorTertiary = Color(0xFF0d2f40);
const colorCuarto = Color(0xff194e71);
const colorQuinto = Color(0xff002b46);
const colorBackground = Colors.white;

const colorTextPrimary = colorSecondary;
const colorTextSecondary = Color(0xFF808B96);
const colorTextTertiary = Color(0xFFB0B1B5);

const colorError = Color(0xFFCC1919);
const colorOff = Color(0xFFEF695B);
const colorWarning = Color(0xFFFADD61);
const colorCreditSecondary = Color(0xFFFE8F21);
const colorSuccess = Color(0xFF009925);
const colorActive = Color(0xFF3CE665);

const colorGray2 = Color(0xFF646464);
const shadowLight = Color(0xffD1D9E6);
const colorGray3 = Color(0xffD5D8DC);
const colorGray4 = Color(0xffFAFAFA);
