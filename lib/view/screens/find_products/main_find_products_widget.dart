import 'package:premium_filter/export.dart';
import 'package:url_launcher/url_launcher.dart';

class MainFindProductsWidget extends StatefulWidget {
  const MainFindProductsWidget({super.key});

  @override
  State<MainFindProductsWidget> createState() => _MainFindProductsWidgetState();
}

class _MainFindProductsWidgetState extends State<MainFindProductsWidget> {
  final controller = Get.find<FindController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
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
                            const SizedBox(
                                height: Dimensions.paddingSizeDefault),
                            BackBtn(),
                            Obx(() => controller.getFAir != null
                                ? buildProductList(
                                    controller.getFAir!.d,
                                    'assets/image/icon-pf.svg',
                                    (item) => item.AIRE,
                                    "AIRE",
                                  )
                                : const SizedBox(
                                    child: Text("no hay data"),
                                  )),
                            Obx(() => controller.getFAirAC != null
                                ? buildProductList(
                                    controller.getFAirAC!.d,
                                    'assets/image/icon-pf.svg',
                                    (item) => item.AIREAC,
                                    "AIREAC")
                                : const SizedBox(
                                    child: Text("no hay data"),
                                  )),
                            Obx(() => controller.getFFuel != null
                                ? buildProductList(
                                    controller.getFFuel!.d,
                                    'assets/image/icon-pf.svg',
                                    (item) => item.Fuel,
                                    "FUEL")
                                : const SizedBox(
                                    child: Text("no hay data"),
                                  )),
                            Obx(() => controller.getFOil != null
                                ? buildProductList(
                                    controller.getFOil!.d,
                                    'assets/image/icon-pf.svg',
                                    (item) => item.ACEITE,
                                    "OIL")
                                : const SizedBox(
                                    child: Text("no hay data"),
                                  )),
                            Obx(() => controller.getFAir == null &&
                                    controller.getFAirAC == null &&
                                    controller.getFFuel == null &&
                                    controller.getFOil == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical:
                                                Dimensions.paddingSizeSmall),
                                        child: Text('noResults'.tr,
                                            style: oswaldRegular.copyWith(
                                                fontSize: 30)),
                                      ),
                                    ],
                                  )
                                : const SizedBox(
                                    child: Text("no hay data en ningun lado"),
                                  )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const NavWidget(showNav: true),
              ],
            )));
  }

  Widget buildProductList(List<dynamic> items, String assetPath,
      String Function(dynamic) getTitle, String typePF) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildProductWidget(items[index], assetPath, getTitle);
      },
    );
  }

  Widget buildProductWidget(
      dynamic item, String assetPath, String Function(dynamic) getTitle) {
    return FutureBuilder<List<dynamic>>(
      future: Get.find<FindController>().getFiltro(pfRef: getTitle(item)),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          debugPrint(snapshot.connectionState.toString());
          return const SizedBox();
        } else {
          debugPrint("snapshot.hasData ${snapshot.hasData}");
          debugPrint("snapshot.data ${snapshot.data}");

          if (!snapshot.hasData) {
            return const SizedBox();
          }
          List<Filter>? item = snapshot.data as List<Filter>;

          return ListView.builder(
              itemCount: item.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    AnimatedContainer(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        border: Border.all(color: Colors.black, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      duration: const Duration(milliseconds: 500),
                      margin: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall),
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Row(
                        children: [
                          Image.network(
                            item[index]
                                .appImg
                                .replaceAll("https:/", "https://"),
                            height: 80,
                            width: 80,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              debugPrint("error $error");
                              return SvgPicture.asset(
                                assetPath,
                                height: 100,
                                width: 100,
                                colorFilter: const ColorFilter.mode(
                                    colorPrimary, BlendMode.srcIn),
                              );
                            },
                          ),
                          const SizedBox(width: Dimensions.paddingSizeDefault),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(item[index].pfRef,
                                  style: oswaldBold.copyWith(fontSize: 30)),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall - 8),
                              item[index].refLinea != null
                                  ? Text(
                                      item[index].refLinea!.toUpperCase(),
                                      style:
                                          nunitoRegular.copyWith(fontSize: 10),
                                    )
                                  : const SizedBox(),
                              item[index].tipoFiltro != null
                                  ? Text(
                                      item[index].tipoFiltro!.toUpperCase(),
                                      style:
                                          nunitoRegular.copyWith(fontSize: 10),
                                    )
                                  : const SizedBox(),
                              item[index].tipo != null
                                  ? Text(
                                      item[index].tipo!.toUpperCase(),
                                      style:
                                          nunitoRegular.copyWith(fontSize: 10),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall - 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 9,
                      right: 0,
                      child: PFButton3(
                        onPressed: () {
                          Get.toNamed(RouteHelper.getViewMoreRoute(), arguments: item[index]);
                        },
                        radius: Dimensions.radiusSmall,
                        padding: EdgeInsets.zero,
                        child: Text(
                          'viewMore'.tr.toUpperCase(),
                          style: oswaldRegular.copyWith(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              });
        }
      },
    );
  }
}
