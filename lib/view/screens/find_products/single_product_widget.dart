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
                            const BackBtn(),
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
        itemCount: controller.srReferences!.d.length,
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
                vertical: Dimensions.paddingSizeDefault),
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Row(
              children: [
                Image.network(
                  "https://automotriz.premiumfilters.com.co/ImagesFilters/${controller.srReferences!.d[index].pfRef}.jpg",
                  height: 100,
                  width: 100,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      SvgPicture.asset(
                    'assets/image/icon-pf.svg',
                    height: 100,
                    width: 100,
                    colorFilter: const ColorFilter.mode(colorPrimary, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.srReferences!.d[index].pfRef.isNotEmpty) ...[
                      Text(controller.srReferences!.d[index].pfRef,
                          style: oswaldBold.copyWith(fontSize: 30)),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                    ],
                    if (controller.srReferences!.d[index].tipo.isNotEmpty) ...[
                      Text(
                          controller.srReferences!.d[index].tipo.tr
                              .toUpperCase(),
                          style: nunitoRegular.copyWith(fontSize: 15)),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    ],
                    if (controller
                        .srReferences!.d[index].fabricante.isNotEmpty) ...[
                      Text(
                          controller.srReferences!.d[index].fabricante.tr
                              .toUpperCase(),
                          style: nunitoRegular.copyWith(fontSize: 15)),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    ],
                    if (controller
                        .srReferences!.d[index].aplicaciones.isNotEmpty) ...[
                      Text(
                          controller.srReferences!.d[index].aplicaciones.tr
                              .toUpperCase(),
                          style: nunitoRegular.copyWith(fontSize: 15)),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    ],
                    if (controller
                        .srReferences!.d[index].equivalencias.isNotEmpty) ...[
                      Text(
                          controller.srReferences!.d[index].equivalencias.tr
                              .toUpperCase(),
                          style: nunitoRegular.copyWith(fontSize: 15)),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    ],
                    PFButton2(
                      onPressed: () {
                        Get.find<FindController>()
                            .getSrFichas(
                                pfRef: controller.srReferences!.d[index].pfRef,
                                type: controller.srReferences!.d[index].tipo)
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
}
