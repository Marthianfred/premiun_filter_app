import 'package:premium_filter/export.dart';

class ManufacturerWidget extends StatefulWidget {
  const ManufacturerWidget({super.key});

  @override
  State<ManufacturerWidget> createState() => _ManufacturerWidgetState();
}

class _ManufacturerWidgetState extends State<ManufacturerWidget> {
  final vehiclesController = Get.find<VehiclesController>();
  late Future manufacturerList;
  final lang = Get.find<LocalizationController>().locale.languageCode;

  @override
  void initState() {
    super.initState();
    vehiclesController.typeApplicationController.addListener(_updateManufacturerList);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateManufacturerList();
  }

  @override
  void dispose() {
    vehiclesController.typeApplicationController.removeListener(_updateManufacturerList);
    super.dispose();
  }

  void _updateManufacturerList() {
    setState(() {
      manufacturerList = vehiclesController.getManufacturer(
          idTMk: vehiclesController.typeApplicationController.text,
          needLoading: vehiclesController.typeApplicationController.text == '1'
              ? true
              : vehiclesController.typeApplicationController.text == '4'
                  ? true
                  : false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: manufacturerList,
        initialData: const [],
        builder: (context, snapshot) {
          return _buildManufacturerWidget(snapshot);
        });
  }

  Widget _buildManufacturerWidget(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return _buildLoadingWidget();
    } else {
      if (!snapshot.hasData || snapshot.data.isEmpty) {
        return _buildEmptyWidget();
      }
      return _buildDropdownWidget(snapshot.data);
    }
  }

  Widget _buildLoadingWidget() {
    return CardEmptyTextWidget(title: 'manufacturer'.tr, textTitle: 'loading'.tr);
  }

  Widget _buildEmptyWidget() {
    return CardEmptyTextWidget(title: 'manufacturer'.tr, textTitle: 'noResults'.tr);
  }

  Widget _buildDropdownWidget(List data) {
    return CardTileDropdownWidget(
        typeApp: vehiclesController.btnPF.value,
        controller: vehiclesController.manufacturerController,
        title: 'manufacturer'.tr,
        language: lang,
        list: data,
        dropDownTitle: 'selectManufacturer'.tr,
        onChanged: (value) async {
          if (value == null || value == '') return;
          vehiclesController.manufacturerController.text = value;
          vehiclesController.yearController.text = '';
          vehiclesController.modelController.text = '';
          vehiclesController.engineController.text = '';

          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {});
          });
        },
        type: PFTypeEnum.getFabricantes);
  }
}
