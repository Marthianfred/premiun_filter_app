import 'package:premium_filter/export.dart';

enum SnackBarType { success, error, warning }

void showCustomSnackBar(BuildContext? context, String? message, {SnackBarType type = SnackBarType.error}) {
  FToast fToast = FToast();
  fToast.init(context ?? Get.context!);

  Widget toast = Container(
    width: Get.width,
    height: 100,
    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
    decoration: BoxDecoration(
      // borderRadius: BorderRadius.circular(25.0),
      color: type == SnackBarType.success
          ? colorSuccess
          : type == SnackBarType.error
              ? colorError
              : colorWarning,
    ),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: message!,
                style: oswaldMedium.copyWith(color: Colors.white),
              ),
            ),
          ),
          Icon(
              type == SnackBarType.success
                  ? Icons.check_circle
                  : type == SnackBarType.error
                      ? Icons.error
                      : Icons.warning,
              color: Colors.white),
        ],
      ),
    ),
  );

  fToast.showToast(
    positionedToastBuilder: (context, child) {
      return Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: SafeArea(child: child),
      );
    },
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 3),
  );
}
