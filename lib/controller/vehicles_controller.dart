import 'package:premium_filter/export.dart';

enum PFTypeEnum {
  getTipoAplicacion,
  getFabricantes,
  getModelos,
  getAnios,
  getMotor,
}

enum BtnPF {
  btnVehicles,
  btnTruckAndBus,
  btnOffRoad,
  btnRefPremium,
  btnEquivalences,
  btnMeasures,
  btnAllReferences
}

class VehiclesController extends GetxController {
  VehiclesController(
      {required this.localizationController, required this.pfRepo});

  final LocalizationController localizationController;
  final PFRepo pfRepo;

  final typeApplicationController = TextEditingController();

  final manufacturerController = TextEditingController();

  final yearController = TextEditingController();

  final modelController = TextEditingController();

  final engineController = TextEditingController();

  final btnPF = BtnPF.btnVehicles.obs;

  final _engines = Rx<EngineModel?>(null);

  get engines => _engines.value;

  Future<List<dynamic>> getTypeApplication({bool needLoading = false}) async {
    return _executeApiCall(
      apiCall: () => pfRepo.GetTipoAplicacion(
          language: Get.find<LocalizationController>().locale.languageCode),
      modelUpdater: (json) => TypeApplicationModel.fromJson(json).data,
      needLoading: needLoading,
    );
  }

  Future<List<dynamic>> getManufacturer(
      {String? idTMk, bool needLoading = false}) async {
    if (idTMk == null || idTMk.isEmpty) {
      return List.empty();
    }

    return _executeApiCall(
      apiCall: () => pfRepo.GetMarcaVehiculo(
        idTMk: int.tryParse(idTMk) ?? 0,
        language: Get.find<LocalizationController>().locale.languageCode,
      ),
      modelUpdater: (json) => ManufacturerModel.fromJson(json).d,
      needLoading: needLoading,
    );
  }

  Future<List<dynamic>> getYear({bool needLoader = false}) async {
    if (typeApplicationController.text.isEmpty) return List.empty();

    return _executeApiCall(
      apiCall: () => pfRepo.GetYear(),
      modelUpdater: (json) => YearModel.fromJson(json).d,
      needLoading: needLoader,
    );
  }

  Future<List<dynamic>> getModel(
      {required String idMk,
      required String idTMk,
      required String year,
      bool needLoader = false}) async {
    return _executeApiCall(
      apiCall: () => pfRepo.GetModel(
        idMk: int.tryParse(idMk) ?? 0,
        idTMk: int.tryParse(idTMk) ?? 0,
        language: Get.find<LocalizationController>().locale.languageCode,
        year: int.tryParse(year) ?? 1234,
      ),
      modelUpdater: (json) => ModelModel.fromJson(json).d,
      needLoading: needLoader,
    );
  }

  Future<List<dynamic>> getEngine(
      {required String idRefMk,
      required String idTMk,
      required String year,
      bool needLoader = false}) async {
    if (idRefMk.isEmpty || idTMk.isEmpty || year.isEmpty) return List.empty();

    return _executeApiCall(
      apiCall: () => pfRepo.GetEngine(
        idRefMk: int.tryParse(idRefMk) ?? 0,
        idTMk: int.tryParse(idTMk) ?? 0,
        language: Get.find<LocalizationController>().locale.languageCode,
        year: int.tryParse(year) ?? 1234,
      ),
      modelUpdater: (json) {
        _engines.value = EngineModel.fromJson(json);
        return _engines.value!.d;
      },
      needLoading: needLoader,
    );
  }

  Future<List<dynamic>> _executeApiCall({
    required Future<Response> Function() apiCall,
    required Function(dynamic json) modelUpdater,
    required bool needLoading,
  }) async {
    if (needLoading) OverlayHelper.start();

    final response = await apiCall();
    if (needLoading) OverlayHelper.stop();

    if (response.statusCode == 1) {
      ApiChecker.checkApi(response);
      return List.empty();
    }

    final json = _processJson(response.bodyString!);

    if (json['d'] is List && json['d'].isEmpty) {
      return List.empty();
    } else if (json['d'] is String) {
      return List.empty();
    }

    return modelUpdater(json);
  }

  dynamic _processJson(String jsonString) {
    return jsonDecode(
      jsonString.removeAllWhitespace
          .replaceAll("\\r\\n", "")
          .replaceAll("\\", "")
          .replaceAll('"[', "[")
          .replaceAll(']"', "]")
          .replaceAll('.0', ""),
    );
  }
}
