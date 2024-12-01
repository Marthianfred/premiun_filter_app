import 'package:premium_filter/export.dart';

class MainErrorScreen extends StatefulWidget {
  final bool isUpdate;

  const MainErrorScreen({super.key, required this.isUpdate});

  @override
  State<MainErrorScreen> createState() => _MainUpdateScreenState();
}

class _MainUpdateScreenState extends State<MainErrorScreen> {
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
              const Icon(Icons.crisis_alert, size: 128, color: colorError),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Text(
                widget.isUpdate ? 'update'.tr : 'we_are_under_error'.tr,
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
