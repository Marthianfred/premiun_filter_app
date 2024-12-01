import 'package:premium_filter/export.dart';

class MainNoConnectionScreen extends StatefulWidget {
  const MainNoConnectionScreen({super.key});

  @override
  State<MainNoConnectionScreen> createState() => _MainNoConnectionState();
}

class _MainNoConnectionState extends State<MainNoConnectionScreen> {
  late StreamSubscription<List<ConnectivityResult>> onConnectivityChanged;

  @override
  void initState() {
    super.initState();
    onConnectivityChanged = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      ConnectivityResult result = results.last;

      bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
      isNotConnected ? const SizedBox() : ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
      if (isNotConnected) {
        showCustomSnackBar(Get.context!, "Ha perdido la conexión", type: SnackBarType.error);
      } else {
        showCustomSnackBar(Get.context!, "Conexión restaurada, redireccionando", type: SnackBarType.success);
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(RouteHelper.getDashboardRoute());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(Icons.crisis_alert, size: 128, color: colorSecondary),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Text(
                'Ha perdido la conexión a internet, por favor intente de nuevo más tarde.',
                style: oswaldRegular.copyWith(color: colorTextPrimary).copyWith(fontSize: Dimensions.fontSizeDefault),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
