import 'package:premium_filter/export.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleProductWidget extends StatefulWidget {
  const SingleProductWidget({super.key});

  @override
  State<SingleProductWidget> createState() => _SingleProductWidgetState();
}

class _SingleProductWidgetState extends State<SingleProductWidget> {
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
                            Obx(() => controller.srReferences != null
                                ? buildProductList()
                                : const SizedBox()),
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

  Widget buildProductList() {
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildProductWidget();
      },
    );
  }

  Widget buildProductWidget() {
    return ListView.builder(
        itemCount: controller.getFilter!.d.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              AnimatedContainer(
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
                      controller.getFilter!.d[index].appImg
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
                          'assets/images/icon-pf.svg',
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
                        Text(controller.getFilter!.d[index].pfRef,
                            style: oswaldBold.copyWith(fontSize: 30)),
                        const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall - 8),
                        controller.getFilter!.d[index].refLinea != null
                            ? Text(
                                controller.getFilter!.d[index].refLinea!
                                    .toUpperCase(),
                                style: nunitoRegular.copyWith(fontSize: 10),
                              )
                            : const SizedBox(),
                        controller.getFilter!.d[index].tipoFiltro != null
                            ? Text(
                                controller.getFilter!.d[index].tipoFiltro!
                                    .toUpperCase(),
                                style: nunitoRegular.copyWith(fontSize: 10),
                              )
                            : const SizedBox(),
                        controller.getFilter!.d[index].tipo != null
                            ? Text(
                                controller.getFilter!.d[index].tipo!
                                    .toUpperCase(),
                                style: nunitoRegular.copyWith(fontSize: 10),
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
                    Get.toNamed(RouteHelper.getViewMoreRoute(),
                        arguments: controller.getFilter!.d[index]);
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
}
