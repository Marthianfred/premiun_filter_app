import 'package:premium_filter/export.dart';

class MainFavoritesScreen extends StatefulWidget {
  const MainFavoritesScreen({super.key});

  @override
  State<MainFavoritesScreen> createState() => _MainFavoritesScreenState();
}

class _MainFavoritesScreenState extends State<MainFavoritesScreen> {
  final List<Map<String, String>> favoriteCategories = [
    {"title": "TODOS", "iconPath": "assets/image/icon-pf.svg"},
    {"title": "AIRE", "iconPath": "assets/image/icon-pf.svg"},
    {"title": "COMBUSTIBLE", "iconPath": "assets/image/icon-pf.svg"},
    {"title": "ACEITE", "iconPath": "assets/image/icon-pf.svg"},
    {"title": "AIRE ACONDICIONADO", "iconPath": "assets/image/icon-pf.svg"},
    {"title": "BASES, SENSORES & VASOS", "iconPath": "assets/image/icon-pf.svg"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackBtn(),
                        Text(
                          'Favoritos',
                          style: oswaldBold.copyWith(fontSize: 24),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Expanded(
                      child: ListView.separated(
                        itemCount: favoriteCategories.length,
                        separatorBuilder: (context, index) => const Divider(color: Colors.grey),
                        itemBuilder: (context, index) {
                          final category = favoriteCategories[index];
                          return FavoriteListWidget(
                            title: category["title"]!,
                            svgImage: SvgPicture.asset(
                              category["iconPath"]!,
                              colorFilter: const ColorFilter.mode(
                                colorPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const NavWidget(showNav: true),
        ],
      ),
    );
  }
}
