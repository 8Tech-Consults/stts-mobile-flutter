import 'package:STTS/models/import_export.dart';

import '../Constants/stts_uganda_exports.dart';

class QualityAssuaranceController extends ChangeNotifier {
  bool isLoading = false;
  dynamic exception;
  List<CropVariety> cropVarieties = [];
  List<ImportExport> importForms = [];
  List<ImportExport> exportForms = [];

  void submitImportPermitForm(
      AddQualityAssuranceForm addQualityAssuranceForm) async {
    try {
      isLoading = true;
      notifyListeners();
      await QualityRepository.submitImportPermit(addQualityAssuranceForm);
      isLoading = false;
      notifyListeners();
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      MethodHelpers.dioErrorHandler(e);
    }

    isLoading = false;
    notifyListeners();
  }

  void submitExportPermitForm(
      AddQualityAssuranceForm addQualityAssuranceForm) async {
    try {
      isLoading = true;
      notifyListeners();
      await QualityRepository.submitExportPermit(addQualityAssuranceForm);
      isLoading = false;
      notifyListeners();
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      MethodHelpers.dioErrorHandler(e);
    }

    isLoading = false;
    notifyListeners();
  }

  Future getCropVarieties() async {
    try {
      cropVarieties = [];
      List<CropVariety> results = await QualityRepository.getCropVarieties();

      cropVarieties.addAll(results);
    } catch (e) {
      rethrow;
    }
  }

  Future getImportForms(int id) async {
    try {
      importForms = [];
      List<ImportExport> results = await QualityRepository.getImportPermits(id);

      importForms.addAll(results);
    } catch (e) {
      rethrow;
    }
  }

  Future getExportForms(int id) async {
    try {
      exportForms = [];
      List<ImportExport> results = await QualityRepository.getExportPermits(id);

      exportForms.addAll(results);
    } catch (e) {
      rethrow;
    }
  }

  void fetchImportForms(id) async {
    if (!isLoading) {
      isLoading = true;
      exception = null;
      notifyListeners();
    }
    try {
      await Future.wait([
        getImportForms(id),
      ], eagerError: true);

      exception = null;
    } catch (e) {
      exception = e;
    }
    isLoading = false;
    notifyListeners();
  }

  void fetchExportForms(id) async {
    if (!isLoading) {
      isLoading = true;
      exception = null;
      notifyListeners();
    }
    try {
      await Future.wait([
        getExportForms(id),
      ], eagerError: true);

      exception = null;
    } catch (e) {
      exception = e;
    }
    isLoading = false;
    notifyListeners();
  }

  void init() async {
    if (!isLoading) {
      isLoading = true;
      exception = null;
      notifyListeners();
    }
    try {
      await Future.wait([
        getCropVarieties(),
      ], eagerError: true);

      exception = null;
    } catch (e) {
      exception = e;
    }
    isLoading = false;
    notifyListeners();
  }
}
