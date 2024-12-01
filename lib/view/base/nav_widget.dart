import 'package:premium_filter/export.dart';

class NavWidget extends StatefulWidget {
  const NavWidget({super.key, this.showNav = true});

  final bool showNav;

  @override
  State<NavWidget> createState() => _NavWidgetState();
}

class _NavWidgetState extends State<NavWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [colorPrimary, colorTertiary, colorPrimary],
        ),
      ),
      height: 80,
      child: widget.showNav
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.offNamed(RouteHelper.getDashboardRoute());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/image/home.svg",
                          width: 50, height: 50),
                      Text('home'.tr,
                          style: nunitoRegular.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('favorites'.tr,
                                style: nunitoBold.copyWith(
                                    color: colorTextPrimary)),
                            content: const SizedBox(
                              width: 300,
                              child: Text(
                                "no in desing.",
                                style: TextStyle(color: colorTextPrimary),
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('close'.tr))
                            ],
                          );
                        });
                    // Get.offNamed(RouteHelper.getFavoritesRoute());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/image/start.svg",
                          width: 50, height: 50),
                      Text('favorites'.tr,
                          style: nunitoRegular.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.offNamed(RouteHelper.getContactRoute());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/image/contact.svg",
                          width: 50, height: 50),
                      Text('contact'.tr,
                          style: nunitoRegular.copyWith(color: Colors.white)),
                    ],
                  ),
                )
              ],
            )
          : const Row(),
    );
  }
}
