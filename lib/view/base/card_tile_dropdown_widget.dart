import 'package:premium_filter/export.dart';

class CardTileDropdownWidget extends StatefulWidget {
  final String title;
  final List<dynamic>? list;
  final String dropDownTitle;
  final TextEditingController? controller;
  final ValueChanged<String?> onChanged;
  final String language;
  final PFTypeEnum type;
  final BtnPF typeApp;

  const CardTileDropdownWidget({
    super.key,
    required this.title,
    required this.list,
    required this.dropDownTitle,
    this.controller,
    required this.onChanged,
    this.language = "es",
    required this.type,
    required this.typeApp,
  });

  @override
  State<CardTileDropdownWidget> createState() => _CardTileDropdownWidgetState();
}

class _CardTileDropdownWidgetState extends State<CardTileDropdownWidget> {
  Map<String, String>? selectedValue;

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case PFTypeEnum.getTipoAplicacion:
        _getTypeApplicationValue("");
        break;
      case PFTypeEnum.getFabricantes:
        _getManufacturerOptions("");
        break;
      case PFTypeEnum.getAnios:
        _getYearOptions("");
        break;
      case PFTypeEnum.getModelos:
        _getModelOptions("");
        break;
      case PFTypeEnum.getMotor:
        _getEngineOptions("");
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitleRow(),
        _buildDropdownRow(),
      ],
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Colors.black,
            ),
            child: Center(
              child: Text(
                widget.title,
                style: oswaldBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeExtraLarge),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Colors.white,
            ),
            child: _buildDropDown(),
          ),
        ),
      ],
    );
  }

  Widget _buildDropDown() {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      initialValue: widget.controller!.text,
      onSelected: (value) {
        setState(() {
          switch (widget.type) {
            case PFTypeEnum.getTipoAplicacion:
              _getTypeApplicationValue(value);
              break;
            case PFTypeEnum.getFabricantes:
              _getManufacturerOptions(value);
              break;
            case PFTypeEnum.getAnios:
              _getYearOptions(value);
              break;
            case PFTypeEnum.getModelos:
              _getModelOptions(value);
              break;
            case PFTypeEnum.getMotor:
              _getEngineOptions(value);
              break;
            default:
              return;
          }
        });
        widget.onChanged(value);
      },
      itemBuilder: (BuildContext context) {
        switch (widget.type) {
          case PFTypeEnum.getTipoAplicacion:
            return _buildTypeApplicationOptions();
          case PFTypeEnum.getFabricantes:
            return _buildManufacturerOptions();
          case PFTypeEnum.getModelos:
            return _buildModelOptions();
          case PFTypeEnum.getAnios:
            return _buildYearOptions();
          case PFTypeEnum.getMotor:
            return _buildEngineOptions();
          default:
            return [];
        }
      },
      child: Padding(
        padding: EdgeInsets.zero,
        child: ListTile(
          title: Text(selectedValue?['text'] ?? widget.controller!.text, style: nunitoRegular),
          trailing: const Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildTypeApplicationOptions() {
    List<TypeApplicationData> options = widget.list as List<TypeApplicationData>;
    options = options.where((element) => element.idTMk == 1 || element.idTMk == 4).toList();
    options.add(TypeApplicationData(idTMk: 0, TAplicacion: 'selectType'.tr, TAplicacionEng: 'selectType'.tr));
    options.sort((a, b) => a.idTMk.compareTo(b.idTMk));

    _getTypeApplicationValue("");

    return options.map((TypeApplicationData option) {
      return PopupMenuItem<String>(
        value: option.idTMk == 0 ? '' : option.idTMk.toString(),
        child: SizedBox(
          width: Get.width * 0.9,
          child: Text(
              option.idTMk == 0
                  ? 'selectType'.tr
                  : widget.language == 'en'
                      ? option.TAplicacionEng.toString()
                      : option.TAplicacion.toString(),
              style: nunitoRegular),
        ),
      );
    }).toList();
  }

  Map<String, String> _getTypeApplicationValue(String value) {
    return selectedValue = {
      'value': value,
      'text': value.isEmpty
          ? "selectType".tr
          : widget.language == 'en'
              ? widget.list!.firstWhere((item) => item.idTMk.toString() == value).TAplicacionEng.toString()
              : widget.list!.firstWhere((item) => item.idTMk.toString() == value).TAplicacion.toString()
    };
  }

  List<PopupMenuEntry<String>> _buildManufacturerOptions() {
    List<ManufacturerData> options = widget.list as List<ManufacturerData>;
    options = options.where((element) => element.idMk != "").toList();
    options.add(ManufacturerData(idMk: "", Marca: 'selectManufacturer'.tr, idTMk: ''));
    options.sort((a, b) => a.idMk.compareTo(b.idMk));
    return options.map((ManufacturerData option) {
      return PopupMenuItem<String>(
        value: option.idMk.toString(),
        child: SizedBox(
          width: Get.width * 0.9,
          child: Text(option.Marca, style: nunitoRegular),
        ),
      );
    }).toList();
  }

  Map<String, String> _getManufacturerOptions(String value) {
    return selectedValue = {'value': value, 'text': value.isEmpty ? "selectManufacturer".tr : widget.list!.firstWhere((item) => item.idMk.toString() == value).Marca.toString()};
  }

  List<PopupMenuEntry<String>> _buildYearOptions() {
    List<YearData> options = widget.list as List<YearData>;
    options = options.where((element) => element.year != "").toList();
    options.add(YearData(year: ""));
    return options.map((YearData option) {
      return PopupMenuItem<String>(
        value: option.year.isEmpty ? "" : option.year.toString(),
        child: SizedBox(
          width: Get.width * 0.9,
          child: Text(option.year.isEmpty ? 'selectYear' : option.year, style: nunitoRegular),
        ),
      );
    }).toList();
  }

  Map<String, String> _getYearOptions(String value) {
    return selectedValue = {'value': value, 'text': value.isEmpty ? "selectYear".tr : widget.list!.firstWhere((item) => item.year.toString() == value).year.toString()};
  }

  List<PopupMenuEntry<String>> _buildModelOptions() {
    List<ModelData> options = widget.list as List<ModelData>;
    options = options.where((element) => element.idRefMk != 0).toList();
    options.add(ModelData(idRefMk: 0, model: 'selectModel'.tr, idMk: 0, idTMk: 0, yearStart: '', yearEnd: ''));
    options.sort((a, b) => a.idRefMk.compareTo(b.idRefMk));
    return options.map((ModelData option) {
      return PopupMenuItem<String>(
        value: option.idRefMk == 0 ? "" : option.idRefMk.toString(),
        child: SizedBox(
          width: Get.width * 0.9,
          child: Text(option.model, style: nunitoRegular),
        ),
      );
    }).toList();
  }

  Map<String, String> _getModelOptions(String value) {
    return selectedValue = {'value': value, 'text': value.isEmpty ? "selectModel".tr : widget.list!.firstWhere((item) => item.idRefMk.toString() == value).model.toString()};
  }

  List<PopupMenuEntry<String>> _buildEngineOptions() {
    List<EngineData> options = widget.list as List<EngineData>;
    options = options.where((element) {
      if (Get.find<VehiclesController>().typeApplicationController.text == "1" || Get.find<VehiclesController>().typeApplicationController.text == "4") {
        return element.McilL != 0;
      } else {
        return element.MotCap != "";
      }
    }).toList();

    options.add(EngineData(McilL: 0, MotCap: "", idRefMk: 0, Mcc: 'selectEngine', yearStart: '', yearEnd: ''));
    return options.map((EngineData option) {
      return PopupMenuItem<String>(
        value: (Get.find<VehiclesController>().typeApplicationController.text == "1" || Get.find<VehiclesController>().typeApplicationController.text == "4")
            ? (option.McilL == 0 ? "" : option.McilL.toString())
            : option.MotCap.toString(),
        child: SizedBox(
          width: Get.width * 0.9,
          child: Text(
              (Get.find<VehiclesController>().typeApplicationController.text == "1" || Get.find<VehiclesController>().typeApplicationController.text == "4")
                  ? (option.McilL == 0 ? "selectEngine".tr : option.Mcc.toString())
                  : (option.MotCap == '' ? "selectEngine".tr : option.MotCap.toString()),
              style: nunitoRegular),
        ),
      );
    }).toList();
  }

  Map<String, String> _getEngineOptions(String value) {
    return selectedValue = {
      'value': value,
      'text': value.isEmpty
          ? "selectEngine".tr
          : (Get.find<VehiclesController>().typeApplicationController.text == "1" || Get.find<VehiclesController>().typeApplicationController.text == "4")
              ? widget.list!.firstWhere((item) => item.McilL.toString() == value).Mcc.toString()
              : widget.list!.firstWhere((item) => item.MotCap.toString() == value).MotCap.toString()
    };
  }
}
