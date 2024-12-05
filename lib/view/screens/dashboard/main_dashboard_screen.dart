import 'package:premium_filter/export.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  final vehiclesController = Get.find<VehiclesController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        const HeaderWidget(),
        Expanded(
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    BackBtn(
                        onTap: () =>
                            Get.offAllNamed(RouteHelper.getLanguageRoute())),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Column(
                      children: <Widget>[
                        DashboardBtnWidget(
                          image: "assets/image/vehicle.svg",
                          text: "vehicles".tr.toUpperCase(),
                          onPress: () {
                            vehiclesController.btnPF.value = BtnPF.btnVehicles;
                            Get.toNamed(RouteHelper.getVehicleRoute());
                          },
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        DashboardBtnWidget(
                          image: "assets/image/truck.svg",
                          text: 'truckAndBus'.tr.toUpperCase(),
                          onPress: () {
                            vehiclesController.btnPF.value =
                                BtnPF.btnTruckAndBus;
                            vehiclesController.typeApplicationController.text =
                                '2';
                            Get.toNamed(RouteHelper.getVehicleRoute());
                          },
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        DashboardBtnWidget(
                          image: "assets/image/off-road.svg",
                          text: 'offRoad'.tr.toUpperCase(),
                          onPress: () {
                            vehiclesController.btnPF.value =
                                BtnPF.btnTruckAndBus;
                            vehiclesController.typeApplicationController.text =
                                '3';
                            Get.toNamed(RouteHelper.getVehicleRoute());
                          },
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        DashboardBtnWidget(
                          image: "assets/image/icon-pf.svg",
                          text: 'refPremium'.tr.toUpperCase(),
                          onPress: () {
                            Get.toNamed(RouteHelper.getRefPremiumRoute());
                          },
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        DashboardBtnWidget(
                          image: "assets/image/equity.svg",
                          text: 'equivalences'.tr.toUpperCase(),
                          onPress: () {
                            Get.toNamed(RouteHelper.getEquivalencesRoute());
                          },
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        DashboardBtnWidget(
                          image: "assets/image/rule.svg",
                          text: 'measures'.tr.toUpperCase(),
                          onPress: () {},
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        DashboardBtnWidget(
                          image: "assets/image/all-references.svg",
                          text: 'allReferences'.tr.toUpperCase(),
                          onPress: () {},
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const NavWidget(showNav: true),
      ],
    ));
  }
}
