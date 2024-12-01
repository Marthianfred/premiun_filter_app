import 'package:premium_filter/export.dart';

class MainFavoritesSreen extends StatefulWidget {
  const MainFavoritesSreen({super.key});

  @override
  State<MainFavoritesSreen> createState() => _MainFavoritesSreenState();
}

class _MainFavoritesSreenState extends State<MainFavoritesSreen> {
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
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    const BackBtn(),

                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        FavoriteListWidget(title: "TODOS", image: Image.asset("assets/image/all.png")),
                        const Divider(color: Colors.grey),
                        FavoriteListWidget(title: "AIRE", image: Image.asset("assets/image/air.png")),
                        const Divider(color: Colors.grey),
                        FavoriteListWidget(title: "COMBUSTIBLE", image: Image.asset("assets/image/gasoline.png")),
                        const Divider(color: Colors.grey),
                        FavoriteListWidget(title: "ACEITE", image: Image.asset("assets/image/aceite.png")),
                        const Divider(color: Colors.grey),
                        FavoriteListWidget(title: "AIRE ACONDICIONADO", image: Image.asset("assets/image/air_conditioner.png")),
                        const Divider(color: Colors.grey),
                        FavoriteListWidget(title: "BASES, SENSORES & VASOS", image: Image.asset("assets/image/base_sensor.png")),
                        const Divider(color: Colors.grey),
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
