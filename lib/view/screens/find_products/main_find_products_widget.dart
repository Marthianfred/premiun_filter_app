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
                            const BackBtn(),
                            Obx(() => controller.getFAir != null
                                ? buildProductList(
                                    controller.getFAir!.d,
                                    'assets/image/icon-pf.svg',
                                    (item) => item.AIRE,
                                    "AIRE")
                                : const SizedBox()),
                            Obx(() => controller.getFAirAC != null
                                ? buildProductList(
                                    controller.getFAirAC!.d,
                                    'assets/image/icon-pf.svg',
                                    (item) => item.AIREAC,
                                    "AIREAC")
                                : const SizedBox()),
                            Obx(() => controller.getFFuel != null
                                ? buildProductList(
                                    controller.getFFuel!.d,
                                    'assets/image/icon-pf.svg',
                                    (item) => item.Fuel,
                                    "FUEL")
                                : const SizedBox()),
                            Obx(() => controller.getFOil != null
                                ? buildProductList(
                                    controller.getFOil!.d,
                                    'assets/image/icon-pf.svg',
                                    (item) => item.ACEITE,
                                    "OIL")
                                : const SizedBox()),
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
                                : const SizedBox())
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

  Widget buildProductWidget(dynamic item, String assetPath,
      String Function(dynamic) getTitle) {
    return FutureBuilder<List<dynamic>>(
      future: Get.find<FindController>().getSrReferences(pfRef: getTitle(item)),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          List<GetSrReferencesData>? item =
              snapshot.data as List<GetSrReferencesData>;

          return ListView.builder(
              itemCount: item.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
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
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Row(
                    children: [
                      Image.network(
                        "https://automotriz.premiumfilters.com.co/ImagesFilters/${item[index].pfRef}.jpg",
                        height: 120,
                        width: 120,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            SvgPicture.asset(
                          assetPath,
                          height: 100,
                          width: 100,
                          colorFilter: const ColorFilter.mode(
                              colorPrimary, BlendMode.srcIn),
                        ),
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
                          Text(item[index].tipo.tr.toUpperCase(),
                              style: nunitoRegular.copyWith(fontSize: 15)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall - 8),
                          Text(item[index].fabricante.tr.toUpperCase(),
                              style: nunitoRegular.copyWith(fontSize: 15)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall - 8),
                          Text(item[index].aplicaciones.tr.toUpperCase(),
                              style: nunitoRegular.copyWith(fontSize: 15)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall - 8),
                          Text(item[index].equivalencias.tr.toUpperCase(),
                              style: nunitoRegular.copyWith(fontSize: 15)),
                          const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall - 8),
                          PFButton2(
                            onPressed: () {
                              Get.find<FindController>()
                                  .getSrFichas(
                                      pfRef: item[index].pfRef,
                                      type: item[index].tipo)
                                  .then((response) {
                                launchUrl(
                                  Uri.parse(response[0].fichaLink),
                                  mode: LaunchMode.externalApplication,
                                );
                              });
                            },
                            radius: Dimensions.radiusSmall,
                            padding: EdgeInsets.zero,
                            child: Text(
                              'viewMore'.tr.toUpperCase(),
                              style: oswaldRegular.copyWith(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        }
      },
    );
  }
}
