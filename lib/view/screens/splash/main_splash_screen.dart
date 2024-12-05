import 'package:premium_filter/export.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;

  const SplashScreen({super.key, required this.body});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: colorBackground,
      body: Obx(
            () => controller.hasConnection.value
            ? const SplashMobileScreen()
            : const SplashMobileScreen(), // mejorar logica de no Internet
      ),
    );
  }
}

