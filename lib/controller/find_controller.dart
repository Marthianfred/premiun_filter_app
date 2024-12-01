import 'package:premium_filter/export.dart';

class FindController extends GetxController {
  FindController({required this.pfRepo, required this.localizationController});

  final PFRepo pfRepo;
  final LocalizationController localizationController;

  final _getFAir = Rx<GetFilterAirModel?>(null);
  final _getFAirAC = Rx<GetFilterAirACModel?>(null);
  final _getFFuel = Rx<GetFilterFuelModel?>(null);
  final _getFOil = Rx<GetFilterOilModel?>(null);
  final _getSrReferences = Rx<GetSrReferences?>(null);

  GetFilterAirModel? get getFAir => _getFAir.value;

  GetFilterAirACModel? get getFAirAC => _getFAirAC.value;

  GetFilterFuelModel? get getFFuel => _getFFuel.value;

  GetFilterOilModel? get getFOil => _getFOil.value;

  GetSrReferences? get srReferences => _getSrReferences.value;

  final _idRefMk = ''.obs;
  final _idTMk = ''.obs;
  final _year = ''.obs;
  final _mCilL = Rx<dynamic>(null);
  final _motCap = ''.obs;

  set idRefMk(String value) => _idRefMk.value = value;

  set idTMk(String value) => _idTMk.value = value;

  set year(String value) => _year.value = value;

  set mCilL(dynamic value) => _mCilL.value = value;

  set motCap(String value) => _motCap.value = value;

  Future<void> getAll() async {
    OverlayHelper.start();
    await getFilterAir();
    await getFilterAirAC();
    await getFilterFuel();
    await getFilterOil();
    OverlayHelper.stop();
  }

  Future<List<dynamic>> getFilterAir() async {
    return _executeApiCall(
      apiCall: () => pfRepo.GetFAir(
        idRefMk: _idRefMk.value,
        idTMk: _idTMk.value,
        language: Get.find<LocalizationController>().locale.languageCode,
        year: _year.value,
        McilL: _mCilL.value,
        MotCap: _motCap.value,
      ),
      modelUpdater: (json) {
        _getFAir.value = GetFilterAirModel.fromJson(json);
        return _getFAir.value!.d;
      },
    );
  }

  Future<List<dynamic>> getFilterAirAC() async {
    return _executeApiCall(
      apiCall: () => pfRepo.GetFAirAC(
        idRefMk: _idRefMk.value,
        idTMk: _idTMk.value,
        language: Get.find<LocalizationController>().locale.languageCode,
        year: _year.value,
        McilL: _mCilL.value,
        MotCap: _motCap.value,
      ),
      modelUpdater: (json) {
        _getFAirAC.value = GetFilterAirACModel.fromJson(json);
        return _getFAirAC.value!.d;
      },
    );
  }

  Future<List<dynamic>> getFilterFuel() async {
    return _executeApiCall(
      apiCall: () => pfRepo.GetFFuel(
        idRefMk: _idRefMk.value,
        idTMk: _idTMk.value,
        language: Get.find<LocalizationController>().locale.languageCode,
        year: _year.value,
        McilL: _mCilL.value,
        MotCap: _motCap.value,
      ),
      modelUpdater: (json) {
        _getFFuel.value = GetFilterFuelModel.fromJson(json);
        return _getFFuel.value!.d;
      },
    );
  }

  Future<List<dynamic>> getFilterOil() async {
    return _executeApiCall(
      apiCall: () => pfRepo.GetFOil(
        idRefMk: _idRefMk.value,
        idTMk: _idTMk.value,
        language: Get.find<LocalizationController>().locale.languageCode,
        year: _year.value,
        McilL: _mCilL.value,
        MotCap: _motCap.value,
      ),
      modelUpdater: (json) {
        _getFOil.value = GetFilterOilModel.fromJson(json);
        return _getFOil.value!.d;
      },
    );
  }

  Future<List<dynamic>> getSrReferences({required String pfRef}) async {
    return _executeApiCall(
      apiCall: () => pfRepo.GetSrReference(
        pfRef: pfRef,
        lang: Get.find<LocalizationController>().locale.languageCode,
      ),
      modelUpdater: (json) {
        _getSrReferences.value = GetSrReferences.fromJson(json);
        return GetSrReferences.fromJson(json).d;
      },
    );
  }

  Future<List<dynamic>> getSrFichas({required String pfRef, required String type}) async {
    return _executeApiCall(
      apiCall: () => pfRepo.GetSrFichas(
        pfRef: pfRef,
        type: type == "AIRE" ? "Air" : type,
        lang: Get.find<LocalizationController>().locale.languageCode,
      ),
      modelUpdater: (json) {
        // _getFOil.value = GetSrReferences.fromJson(json);
        return GetSrFichas.fromJson(json).d;
      },
    );
  }

  Future<List<dynamic>> _executeApiCall({
    required Future<Response> Function() apiCall,
    required Function(dynamic json) modelUpdater,
  }) async {
    final response = await apiCall();

    if (response.statusCode == 1 || response.statusCode != 200) {
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
      jsonString.replaceAll("\\r\\n", "").replaceAll("\\", "").replaceAll('"[', "[").replaceAll(']"', "]").replaceAll('.0', ""),
    );
  }
}
