import 'package:premium_filter/export.dart';

class MainLanguageScreen extends StatefulWidget {
  const MainLanguageScreen({super.key});

  @override
  State<MainLanguageScreen> createState() => _MainLanguageScreenState();
}

class _MainLanguageScreenState extends State<MainLanguageScreen> {
  final localizationController = Get.find<LocalizationController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // necesito 3 contenedores de colores diferentes. el den centro debe ser expandible
      child: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Row(),
                  PFButton2(
                      onPressed: () {
                        localizationController.setLanguage(Locale(
                          AppConstants.languages[1].languageCode!,
                          AppConstants.languages[1].countryCode,
                        ));
                        Get.toNamed(RouteHelper.getDashboardRoute());
                      },
                      child: Text(
                        'english'.tr.toUpperCase(),
                        style: oswaldBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeOverExtraLarge),
                      )),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  PFButton2(
                      onPressed: () {
                        localizationController.setLanguage(Locale(
                          AppConstants.languages[0].languageCode!,
                          AppConstants.languages[0].countryCode,
                        ));
                        Get.toNamed(RouteHelper.getDashboardRoute());
                      },
                      child: Text(
                        'spanish'.tr.toUpperCase(),
                        style: oswaldBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeOverExtraLarge),
                      )),
                ],
              ),
            ),
          ),
          const NavWidget(showNav: false),
        ],
      ),
    );
  }
}
