import 'package:premium_filter/export.dart';

class MainUpdateScreen extends StatefulWidget {
  final bool isUpdate;

  const MainUpdateScreen({super.key, required this.isUpdate});

  @override
  State<MainUpdateScreen> createState() => _MainUpdateScreenState();
}

class _MainUpdateScreenState extends State<MainUpdateScreen> {
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

              const SizedBox(height: Dimensions.paddingSizeDefault),
              Text(
                widget.isUpdate ? 'update'.tr : 'we_are_under_maintenance'.tr,
                style: oswaldRegular.copyWith(color: colorTextPrimary).copyWith(fontSize: Dimensions.fontSizeDefault),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Text(
                widget.isUpdate ? 'your_app_is_deprecated'.tr : 'we_will_be_right_back'.tr,
                style: oswaldRegular.copyWith(fontSize: MediaQuery.of(context).size.height * 0.0175, color: Theme.of(context).disabledColor),
                textAlign: TextAlign.center,
              ),
              const Spacer(),

              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
