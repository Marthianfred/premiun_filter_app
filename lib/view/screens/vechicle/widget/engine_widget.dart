import 'package:premium_filter/export.dart';

class EngineWidget extends StatefulWidget {
  const EngineWidget({super.key});

  @override
  State<EngineWidget> createState() => _EngineWidgetState();
}

class _EngineWidgetState extends State<EngineWidget> {
  final vehiclesController = Get.find<VehiclesController>();
  final lang = Get.find<LocalizationController>().locale.languageCode;

  late Future engineList;

  @override
  void initState() {
    super.initState();
    engineList = vehiclesController.getEngine(
      idTMk: vehiclesController.typeApplicationController.text,
      year: vehiclesController.yearController.text,
      idRefMk: vehiclesController.modelController.text,
      needLoader: true,
    );

    vehiclesController.modelController.addListener(_updateEngineList);
  }

  void _updateEngineList() {
    setState(() {
      engineList = vehiclesController.getEngine(
        idTMk: vehiclesController.typeApplicationController.text,
        year: vehiclesController.yearController.text,
        idRefMk: vehiclesController.modelController.text,
        needLoader: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: engineList,
      initialData: const [],
      builder: (context, snapshot) {
        return _buildEngineWidget(snapshot);
      },
    );
  }

  Widget _buildEngineWidget(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return _buildLoadingWidget();
    } else if(snapshot.hasError){
      return CardEmptyTextWidget(title: 'engine'.tr, textTitle: snapshot.error.toString());
    } else {
      if (!snapshot.hasData || snapshot.data.isEmpty) {
        return _buildEmptyWidget();
      }
      return _buildDropdownWidget(snapshot.data);
    }
  }

  Widget _buildLoadingWidget() {
    return CardEmptyTextWidget(title: 'engine'.tr, textTitle: 'loading'.tr);
  }

  Widget _buildEmptyWidget() {
    return CardEmptyTextWidget(title: 'engine'.tr, textTitle: 'noResults'.tr);
  }

  Widget _buildDropdownWidget(List data) {
    return CardTileDropdownWidget(
      typeApp: vehiclesController.btnPF.value,
      controller: vehiclesController.engineController,
      title: 'engine'.tr,
      language: lang,
      list: data,
      dropDownTitle: 'selectEngine'.tr,
      onChanged: (value) async {
        if (value == null || value == '') return;
        vehiclesController.engineController.text = value;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {});
        });
      },
      type: PFTypeEnum.getMotor,
    );
  }
}
