import 'package:premium_filter/export.dart';

class TypeApplicationWidget extends StatefulWidget {
  const TypeApplicationWidget({super.key, required this.type});

  final BtnPF type;

  @override
  State<TypeApplicationWidget> createState() => _TypeApplicationWidgetState();
}

class _TypeApplicationWidgetState extends State<TypeApplicationWidget> {
  final vehiclesController = Get.find<VehiclesController>();
  late Future typeApp;

  @override
  void initState() {
    super.initState();
    typeApp = vehiclesController.getTypeApplication();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: typeApp,
        initialData: const [],
        builder: (context, snapshot) {
          return _buildTypeApplicationWidget(snapshot);
        });
  }

  Widget _buildTypeApplicationWidget(AsyncSnapshot snapshot) {
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
    return CardEmptyTextWidget(title: 'typeApplication'.tr, textTitle: 'loading'.tr);
  }

  Widget _buildEmptyWidget() {
    return CardEmptyTextWidget(title: 'typeApplication'.tr, textTitle: 'noResults'.tr);
  }

  Widget _buildDropdownWidget(List data) {
    final lang = Get.find<LocalizationController>().locale.languageCode;

    return CardTileDropdownWidget(
        typeApp: widget.type,
        controller: vehiclesController.typeApplicationController,
        title: 'typeApplication'.tr,
        language: lang,
        list: data,
        dropDownTitle: 'selectType'.tr,
        onChanged: (value) async {
          if (value == null || value == '') return;

          vehiclesController.typeApplicationController.text = value;
          vehiclesController.manufacturerController.text = '';
          vehiclesController.yearController.text = '';
          vehiclesController.modelController.text = '';
          vehiclesController.engineController.text = '';

          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {});
          });
        },
        type: PFTypeEnum.getTipoAplicacion);
  }
}
