import 'package:premium_filter/export.dart';

class RefreshController extends GetxController {
  Future<void> Function()? onRefresh;

  void setOnRefresh(Future<void> Function() newOnRefresh) {
    onRefresh = newOnRefresh;
    update();
  }

  void clearOnRefresh() {
    onRefresh = null;
    update();
  }
}
