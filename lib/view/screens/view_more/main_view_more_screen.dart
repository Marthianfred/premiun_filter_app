import 'package:premium_filter/export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MainViewMoreScreen extends StatefulWidget {
  const MainViewMoreScreen({super.key});

  @override
  State<MainViewMoreScreen> createState() => _MainViewMoreScreenState();
}

class _MainViewMoreScreenState extends State<MainViewMoreScreen> {
  late Filter filter;
  Database? _database;

  @override
  void initState() {
    super.initState();

    filter = Get.arguments as Filter;

    _initDatabase();
  }

  Future<void> _initDatabase() async {
    try {
      String dbPath = await getDatabasesPath();
      String path = join(dbPath, 'favorite_filters.db');

      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS favorites (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              pfRef TEXT,
              refLinea TEXT
            )
          ''');
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      // Get.snackbar('Error', 'No se pudo inicializar la base de datos',
      //     snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addFavorite() async {
    if (_database == null) {
      // Verificamos si la base de datos está lista
      Get.snackbar('Error', 'Base de datos no inicializada',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      await _database!.insert(
        'favorites',
        {
          'pfRef': filter.pfRef,
          'refLinea': filter.refLinea ?? 'N/A',
        },
        conflictAlgorithm: ConflictAlgorithm.replace, // Evita duplicados
      );
      Get.snackbar('Favorito', 'Filtro añadido a favoritos',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'No se pudo añadir el favorito',
          snackPosition: SnackPosition.BOTTOM);
    }
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
                        horizontal: Dimensions.paddingSizeLarge),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BackBtn(),
                            IconButton(
                              icon: const Icon(
                                Icons.star,
                                color: colorCuarto,
                                size: 60,
                              ),
                              onPressed: () {
                                addFavorite();
                              },
                            ),
                          ],
                        ),
                        Center(
                          child: Image.network(
                            filter.appImg.replaceAll("https:/", "https://"),
                            width: MediaQuery.of(context).size.width * 0.6,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return SvgPicture.asset(
                                'assets/image/icon-pf.svg',
                                width: MediaQuery.of(context).size.width * 0.6,
                                colorFilter: const ColorFilter.mode(
                                    colorPrimary, BlendMode.srcIn),
                              );
                            },
                          ),
                        ),
                        Center(
                          child: PFButton(
                            onPressed: () {
                              if (filter.pdf != null) {
                                launchUrl(Uri.parse(filter.pdf!));
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ficha Tecnica',
                                  style: oswaldRegular.copyWith(
                                      fontSize: 30, color: Colors.white),
                                ),
                                const SizedBox(
                                    width: Dimensions.paddingSizeDefault),
                                const Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text(
                          'Principales aplicaciones:',
                          style: oswaldBold.copyWith(fontSize: 24),
                        ),
                        filter.app != null
                            ? Text(
                          filter.app!,
                          style: nunitoRegular.copyWith(fontSize: 16),
                        )
                            : const SizedBox(),
                        filter.dAlto != null
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Alto:'.toUpperCase(),
                              style: oswaldBold.copyWith(fontSize: 24),
                            ),
                            Text(
                              filter.dAlto!,
                              style: nunitoRegular.copyWith(fontSize: 16),
                            ),
                          ],
                        )
                            : const SizedBox(),
                        filter.dLargo != null
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Largo:'.toUpperCase(),
                              style: oswaldBold.copyWith(fontSize: 24),
                            ),
                            Text(
                              filter.dLargo!,
                              style: nunitoRegular.copyWith(fontSize: 16),
                            ),
                          ],
                        )
                            : const SizedBox(),
                        filter.dAncho != null
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ancho:'.toUpperCase(),
                              style: oswaldBold.copyWith(fontSize: 24),
                            ),
                            Text(
                              filter.dAncho!,
                              style: nunitoRegular.copyWith(fontSize: 16),
                            ),
                          ],
                        )
                            : const SizedBox(),
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
