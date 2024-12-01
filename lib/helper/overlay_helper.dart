import 'package:premium_filter/export.dart';

class OverlayHelper {
  static void start() {
    OverlayLoadingProgress.start(Get.context as BuildContext,
        barrierDismissible: false,
        widget: const CircularProgressIndicator(
          color: colorError,
        ));
  }

  static void stop() {
    OverlayLoadingProgress.stop();
  }
}
