import 'package:premium_filter/export.dart';

class ModelWidget extends StatefulWidget {
  const ModelWidget({super.key});

  @override
  State<ModelWidget> createState() => _ModelWidgetState();
}

class _ModelWidgetState extends State<ModelWidget> {
  final vehiclesController = Get.find<VehiclesController>();
  final lang = Get.find<LocalizationController>().locale.languageCode;

  late Future modelList;

  @override
  void initState() {
    super.initState();
    modelList = Future.delayed(const Duration(seconds: 1), () {
      return [];
    });

    vehiclesController.yearController.addListener(_updateModelList);
  }

  void _updateModelList() {
    setState(() {
      modelList = vehiclesController.getModel(
        needLoader: true,
        idMk: vehiclesController.manufacturerController.text,
        idTMk: vehiclesController.typeApplicationController.text,
        year: vehiclesController.yearController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: modelList,
        initialData: const [],
        builder: (context, snapshot) {
          return _buildModelWidget(snapshot);
        });
  }

  Widget _buildModelWidget(AsyncSnapshot snapshot) {
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
    return CardEmptyTextWidget(title: 'model'.tr, textTitle: 'loading'.tr);
  }

  Widget _buildEmptyWidget() {
    return CardEmptyTextWidget(title: 'model'.tr, textTitle: 'noResults'.tr);
  }

  Widget _buildDropdownWidget(List data) {
    return CardTileDropdownWidget(
        typeApp: vehiclesController.btnPF.value,
        controller: vehiclesController.modelController,
        title: 'model'.tr,
        language: lang,
        list: data,
        dropDownTitle: 'selectModel'.tr,
        onChanged: (value) async {
          if (value == null || value == '') return;
          vehiclesController.modelController.text = value;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {});
          });
        },
        type: PFTypeEnum.getModelos);
  }
}