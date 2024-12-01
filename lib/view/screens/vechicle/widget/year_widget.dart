import 'package:premium_filter/export.dart';

class YearWidget extends StatefulWidget {
  const YearWidget({super.key});

  @override
  State<YearWidget> createState() => _YearWidgetState();
}

class _YearWidgetState extends State<YearWidget> {
  final vehiclesController = Get.find<VehiclesController>();
  final lang = Get.find<LocalizationController>().locale.languageCode;

  late Future yearList;

  @override
  void initState() {
    super.initState();
    yearList = Future.delayed(const Duration(seconds: 1), () {
      return List.empty();
    });
    vehiclesController.manufacturerController.addListener(_updateYearList);
  }

  void _updateYearList() {
    setState(() {
      yearList = vehiclesController.getYear(needLoader: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: yearList,
        initialData: const [],
        builder: (context, snapshot) {
          return _buildYearWidget(snapshot);
        });
  }

  Widget _buildYearWidget(AsyncSnapshot snapshot) {
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
    return CardEmptyTextWidget(title: 'year'.tr, textTitle: 'loading'.tr);
  }

  Widget _buildEmptyWidget() {
    return CardEmptyTextWidget(title: 'year'.tr, textTitle: 'noResults'.tr);
  }

  Widget _buildDropdownWidget(List data) {
    return CardTileDropdownWidget(
        typeApp: vehiclesController.btnPF.value,
        controller: vehiclesController.yearController,
        title: 'year'.tr,
        language: lang,
        list: data,
        dropDownTitle: 'selectYear'.tr,
        onChanged: (value) async {
          if (value == null || value == '') return;
          vehiclesController.yearController.text = value;
          vehiclesController.modelController.text = '';
          vehiclesController.engineController.text = '';
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {});
          });
        },
        type: PFTypeEnum.getAnios);
  }
}
