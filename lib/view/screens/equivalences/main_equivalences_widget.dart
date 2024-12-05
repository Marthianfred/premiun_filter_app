import 'package:premium_filter/export.dart';

class MainEquivalencesWidget extends StatefulWidget {
  const MainEquivalencesWidget({super.key});

  @override
  State<MainEquivalencesWidget> createState() => _MainEquivalencesWidgetState();
}

class _MainEquivalencesWidgetState extends State<MainEquivalencesWidget> {
  final controller = Get.find<RefController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.white,
      child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: HeaderWidget(),
              ),
              Positioned(
                top: Dimensions.paddingSizeDefault * 10,
                left: Dimensions.paddingSizeDefault,
                child: BackBtn(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: CardTextFieldWithIconWidget(
                    title: 'Equivalencias'.tr.toUpperCase(),
                    controller: controller.refTextController,
                    textTitle: "insertNumberRef".tr.toUpperCase(),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: NavWidget(showNav: true),
              )
            ],
          )),
    ));
  }
}
