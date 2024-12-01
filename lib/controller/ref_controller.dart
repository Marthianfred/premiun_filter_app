import 'package:premium_filter/export.dart';

class RefController extends GetxController {
  RefController({required this.pfRepo, required this.localizationController});

  final PFRepo pfRepo;
  final LocalizationController localizationController;

  final refTextController = TextEditingController();
}
