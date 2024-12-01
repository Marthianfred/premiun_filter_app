import 'package:premium_filter/export.dart';
import 'package:url_launcher/url_launcher.dart';

class MainContactScreen extends StatefulWidget {
  const MainContactScreen({super.key});

  @override
  State<MainContactScreen> createState() => _MainContactScreenState();
}

class _MainContactScreenState extends State<MainContactScreen> {
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
                    Center(
                      child: ContactBtnWidget(
                        onTap: () async {
                          await launchUrl(Uri.parse(""));
                        },
                        isPrincipal: true,
                        image: SvgPicture.asset("assets/image/15-25.svg",
                            width: 80, height: 80),
                        text: "contact_us".tr,
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault * 2),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: Dimensions.paddingSizeExtraSmall,
                      mainAxisSpacing: Dimensions.paddingSizeExtraSmall,
                      children: [
                        if (Get.find<LocalizationController>()
                                .locale
                                .languageCode ==
                            "en") ...[
                          ContactBtnWidget(
                            onTap: () async => await launchUrl(
                                Uri.parse("tel:+1-305-490-3602")),
                            image: SvgPicture.asset(
                              "assets/image/16-25.svg",
                              width: 80,
                              height: 80,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                            text: "commercial_advisor".tr,
                          ),
                          ContactBtnWidget(
                            onTap: () async => await launchUrl(
                                Uri.parse("mailto:info@premfilt.com")),
                            image: SvgPicture.asset(
                              "assets/image/20-25.svg",
                              width: 80,
                              height: 80,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                            text: "email".tr,
                          ),
                          ContactBtnWidget(
                            onTap: () async => await launchUrl(
                                Uri.parse("https://premfilt.com/")),
                            image: SvgPicture.asset(
                              "assets/image/18-25.svg",
                              width: 80,
                              height: 80,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                            text: "web_page".tr,
                          ),
                        ],
                        if (Get.find<LocalizationController>()
                                .locale
                                .languageCode ==
                            "es") ...[
                          ContactBtnWidget(
                            onTap: () async =>
                                await launchUrl(Uri.parse("tel:6014211077")),
                            image: SvgPicture.asset(
                              "assets/image/16-25.svg",
                              width: 80,
                              height: 80,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                            text: "commercial_advisor".tr,
                          ),
                          ContactBtnWidget(
                            onTap: () async => await launchUrl(Uri.parse(
                                "mailto:comercial1@premiumfilters.com.co")),
                            image: SvgPicture.asset(
                              "assets/image/20-25.svg",
                              width: 80,
                              height: 80,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                            text: "email".tr,
                          ),
                          ContactBtnWidget(
                            onTap: () async => await launchUrl(
                                Uri.parse("https://premiumfilters.co/")),
                            image: SvgPicture.asset(
                              "assets/image/18-25.svg",
                              width: 80,
                              height: 80,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                            text: "web_page".tr,
                          ),
                          ContactBtnWidget(
                              onTap: () async => await launchUrl(
                                  Uri.parse("https://wa.link/kzzqlx")),
                              image: SvgPicture.asset(
                                "assets/image/15-25.svg",
                                width: 80,
                                height: 80,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                              ),
                              text: "whatsapp".tr),
                          ContactBtnWidget(
                              onTap: () async => await launchUrl(
                                  Uri.parse("https://premiumfilters.store/")),
                              image: SvgPicture.asset(
                                "assets/image/15-25.svg",
                                width: 80,
                                height: 80,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                              ),
                              text: "online_store"),
                          ContactBtnWidget(
                              onTap: () async => await launchUrl(Uri.parse(
                                  "https://www.instagram.com/premiumfilters/")),
                              image: SvgPicture.asset(
                                "assets/image/15-25.svg",
                                width: 80,
                                height: 80,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                              ),
                              text: "REDES \n SOCIALES"),
                        ],
                      ],
                    ),
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
