import 'package:STTS/models/accepted_model.dart';
import 'package:STTS/models/add_sample_analysis.dart';
import 'package:STTS/models/add_seed_lab.dart';
import 'package:STTS/models/add_seed_label.dart';
import 'package:STTS/models/add_stock_form.dart';
import 'package:STTS/models/lab_test_number.dart';
import 'package:STTS/models/seed_lab.dart';
import 'package:STTS/models/seed_label.dart';
import 'package:STTS/models/seed_label_package.dart';
import 'package:STTS/models/seed_stock.dart';
import 'package:STTS/models/stock_examination.dart';
import 'package:STTS/models/update_lab_results.dart';
import 'package:STTS/repositories/planting_repository.dart';
import '../Constants/stts_uganda_exports.dart';
import '../repositories/seed_repository.dart';

class SeedController extends ChangeNotifier {
  bool isLoading = false;
  dynamic exception;
  List<AcceptedModel> acceptedPermits = [];
  List<AcceptedModel> acceptedPlantingReturns = [];
  List<AcceptedModel> acceptedQds = [];
  List<AcceptedModel> acceptedCropVarieries = [];
  List<StockExamination> stockExaminations = [];
  List<SeedLab> seedLabs = [];
  List<SeedLabel> seedLabels = [];
  List<SeedStock> seedStocks = [];
  List<CropVariety> cropVarieties = [];
  List<SeedLabelPackage> seedLabelsPackages = [];
  List<LabTestNumber> labtestnumbers = [];

  Future getAcceptedPlantingReturns(userId) async {
    try {
      acceptedPlantingReturns = [];
      List<AcceptedModel> results =
          await SeedRepository.getAcceptedPlantingReturns(userId);

      acceptedPlantingReturns.addAll(results);
    } catch (e) {
      rethrow;
    }
  }

  Future getSeedLabelPackages() async {
    try {
      seedLabelsPackages = [];
      List<SeedLabelPackage> results =
          await SeedRepository.getSeedLabelPackages();

      seedLabelsPackages.addAll(results);
    } catch (e) {
      rethrow;
    }
  }

  Future getLabTestNumbers(userId) async {
    try {
      labtestnumbers = [];
      List<LabTestNumber> results =
          await SeedRepository.getLabTestNumbers(userId);

      labtestnumbers.addAll(results);
    } catch (e) {
      rethrow;
    }
  }

  Future getAcceptedQds(userId) async {
    try {
      acceptedQds = [];
      List<AcceptedModel> results = await SeedRepository.getAcceptedQDS(userId);

      acceptedQds.addAll(results);
    } catch (e) {
      rethrow;
    }
  }

  Future getAcceptedPermits(userId) async {
    try {
      acceptedPermits = [];
      List<AcceptedModel> results =
          await SeedRepository.getAcceptedPermits(userId);

      acceptedPermits.addAll(results);
    } catch (e) {
      rethrow;
    }
  }

  void submitSeedLabels(AddSeedLabel addSeedLabel) async {
    try {
      isLoading = true;
      notifyListeners();
      await SeedRepository.submitSeedLabel(addSeedLabel);
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      MethodHelpers.dioErrorHandler(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void submitSeedExam(AddStockExam addStockExam) async {
    try {
      isLoading = true;
      notifyListeners();
      await SeedRepository.submitSeedExam(addStockExam);
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      if (e is DioError) {}
      MethodHelpers.dioErrorHandler(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void submitSeedExamForm(AddStockForm addStockForm, id) async {
    try {
      isLoading = true;
      notifyListeners();
      await SeedRepository.submitStockExamForm(addStockForm, id);
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      if (e is DioError) {}
      MethodHelpers.dioErrorHandler(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void submitSeedSampleAnalysis(AddSampleAnalysis addSampleAnalysis, id) async {
    try {
      isLoading = true;
      notifyListeners();
      await SeedRepository.submitSeedSampleAnalysis(addSampleAnalysis, id);
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      if (e is DioError) {}
      MethodHelpers.dioErrorHandler(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void submitLabTest(UpdateLabResults updateLabResults, id) async {
    try {
      isLoading = true;
      notifyListeners();
      await SeedRepository.submitLabTest(updateLabResults, id);
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      if (e is DioError) {}
      MethodHelpers.dioErrorHandler(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void submitLocalSeedExam(AddStockExam addStockExam) async {
    try {
      isLoading = true;
      notifyListeners();
      await SeedRepository.saveStockExamination(addStockExam);
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      if (e is DioError) {}
      MethodHelpers.dioErrorHandler(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void init(userId) async {
    if (!isLoading) {
      isLoading = true;
      exception = null;
      notifyListeners();
    }
    try {
      await Future.wait([
        getAcceptedPlantingReturns(userId),
        getAcceptedQds(userId),
        getAcceptedPermits(userId),
      ], eagerError: true);

      exception = null;
    } catch (e) {
      exception = e;
    }
    isLoading = false;
    notifyListeners();
  }

  void fetchCropVarieties(int permitId) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      acceptedCropVarieries = [];
      List<AcceptedModel> results =
          await SeedRepository.getAcceptedCropVarieties(permitId);

      acceptedCropVarieries.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchSeedLabels(userId) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      seedLabels = [];
      List<SeedLabel> results = await SeedRepository.getSeedLabels(userId);

      seedLabels.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchStockExaminations(userId) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      stockExaminations = [];
      List<StockExamination> results =
          await SeedRepository.getStockExaminations(userId);

      stockExaminations.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchUserCropVarieties() async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      cropVarieties = [];
      List<CropVariety> results = await QualityRepository.getCropVarieties();

      cropVarieties.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void submitSeedLab(AddSeedLab addSeedLab) async {
    try {
      isLoading = true;
      notifyListeners();
      await PlantingRepository.submitSeedLabs(addSeedLab);
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      MethodHelpers.dioErrorHandler(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void fetchSeedLabs(userId) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      seedLabs = [];
      List<SeedLab> results = await SeedRepository.getSeedLabs(userId);
      seedLabs.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchSeedStocks(userId) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      seedStocks = [];
      List<SeedStock> results = await SeedRepository.getSeedStocks(userId);
      seedStocks.addAll(results);
    } catch (e) {
      exception = e;
    }
    isLoading = false;
    notifyListeners();
  }

  void fetchSeedLabelData(userId) async {
    if (!isLoading) {
      isLoading = true;
      exception = null;
      notifyListeners();
    }
    try {
      await Future.wait([
        getLabTestNumbers(userId),
        getSeedLabelPackages(),
      ], eagerError: true);

      exception = null;
    } catch (e) {
      exception = e;
    }
    isLoading = false;
    notifyListeners();
  }
}
