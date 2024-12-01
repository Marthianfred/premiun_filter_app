import 'package:premium_filter/export.dart';

class MainVehicleScreen extends StatefulWidget {
  const MainVehicleScreen({super.key});

  @override
  State<MainVehicleScreen> createState() => _MainVehicleScreenState();
}

class _MainVehicleScreenState extends State<MainVehicleScreen> {
  final vehiclesController = Get.find<VehiclesController>();
  final findController = Get.find<FindController>();

  Future<void> _refreshData() async {
    vehiclesController.typeApplicationController.text = "";
    vehiclesController.manufacturerController.text = "";
    vehiclesController.yearController.text = "";
    vehiclesController.modelController.text = "";
    vehiclesController.engineController.text = "";
    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        child: Column(
          children: [
            const HeaderWidget(),
            _buildExpanded(),
            const NavWidget(showNav: true),
          ],
        ),
      ),
    );
  }

  Expanded _buildExpanded() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: RefreshIndicator(
          onRefresh: _refreshData,
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
                  _buildListView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView _buildListView() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        if (vehiclesController.btnPF.value == BtnPF.btnVehicles) ...[
          // Type Application
          TypeApplicationWidget(type: vehiclesController.btnPF.value),
          const SizedBox(height: Dimensions.paddingSizeSmall),
        ],
        // Manufacturer
        const ManufacturerWidget(),
        // if (vehiclesController.btnPF.value == BtnPF.btnVehicles) ...[
        const SizedBox(height: Dimensions.paddingSizeSmall),
        const YearWidget(),
        // ],
        const SizedBox(height: Dimensions.paddingSizeSmall),
        const ModelWidget(),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        const EngineWidget(),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        _buildSearchButton(),
        const SizedBox(height: Dimensions.paddingSizeSmall),
      ],
    );
  }

  Center _buildSearchButton() {
    return Center(
      child: PFButton2(
        onPressed: _onSearchButtonPressed,
        child: Text('search'.tr.toUpperCase(), style: oswaldBold.copyWith(color: Colors.white, fontSize: 24)),
      ),
    );
  }

  Future<void> _onSearchButtonPressed() async {
    if (!isFormValid()) {
      return;
    }

    findController.idRefMk = vehiclesController.modelController.text;
    findController.idTMk = vehiclesController.typeApplicationController.text;
    findController.year = vehiclesController.yearController.text;

    if (vehiclesController.typeApplicationController.text == "1" || vehiclesController.typeApplicationController.text == "4") {
      findController.mCilL = vehiclesController.engineController.text;
      findController.motCap = "";
    } else {
      findController.mCilL = vehiclesController.engines.d.firstWhere((item) => item.MotCap.toString() == vehiclesController.engineController.text).McilL;
      findController.motCap = vehiclesController.engineController.text;
    }
    await findController.getAll();
    Get.toNamed(RouteHelper.getFindProductsRoute());
  }

  bool isFormValid() {
    if (vehiclesController.typeApplicationController.text.isEmpty) {
      Get.snackbar('Error', vehiclesController.localizationController.locale.languageCode == 'en' ? 'Type Application is required' : 'Tipo de Aplicación es requerido');
      return false;
    }

    if (vehiclesController.manufacturerController.text.isEmpty) {
      Get.snackbar('Error', vehiclesController.localizationController.locale.languageCode == 'en' ? 'Manufacturer is required' : 'Fabricante es requerido');
      return false;
    }

    if (vehiclesController.yearController.text.isEmpty) {
      Get.snackbar('Error', vehiclesController.localizationController.locale.languageCode == 'en' ? 'Year is required' : 'Año es requerido');
      return false;
    }

    if (vehiclesController.modelController.text.isEmpty) {
      Get.snackbar('Error', vehiclesController.localizationController.locale.languageCode == 'en' ? 'Model is required' : 'Modelo es requerido');
      return false;
    }

    if (vehiclesController.engineController.text.isEmpty) {
      Get.snackbar('Error', vehiclesController.localizationController.locale.languageCode == 'en' ? 'Engine is required' : 'Motor es requerido');
      return false;
    }

    return true;
  }
}
