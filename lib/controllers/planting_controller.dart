import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/models/add_crop_declaration.dart';
import 'package:STTS/models/add_inspection.dart';
import 'package:STTS/models/add_planting_return.dart';
import 'package:STTS/models/assigned_sub_grower.dart';
import 'package:STTS/models/crop.dart';
import 'package:STTS/models/crop_declaration.dart';
import 'package:STTS/models/inspection.dart';
import 'package:STTS/models/updateCropDeclaration.dart';
import 'package:STTS/models/update_planting_return.dart';
import 'package:STTS/repositories/planting_repository.dart';

class PlantingController extends ChangeNotifier {
  bool isLoading = false;
  dynamic exception;
  List<Crop> crops = [];
  List<CropVariety> cropVarieties = [];
  List<AssignedInpection> inspections = [];
  List<AssignedInpection> plantingReturns = [];
  List<CropDeclaration> cropDeclarations = [];
  List<Inspection> assignedS10s = [];
  List<Inspection> assignedQDs = [];

  Future getCrops() async {
    try {
      crops = [];
      List<Crop> results = await PlantingRepository.getCrops();

      crops.addAll(results);
    } catch (e) {
      rethrow;
    }
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

  void submitPlantingReturn(AddPlantingReturn addPlantingReturn) async {
    try {
      isLoading = true;
      notifyListeners();
      await PlantingRepository.submitPlantingReturn(addPlantingReturn);
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

  void updatePlantingReturn(
      UpdatePlantingReturn updatePlantingReturn, id) async {
    try {
      isLoading = true;
      notifyListeners();
      await PlantingRepository.updatePlantingReturn(updatePlantingReturn, id);
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

  void updateQDSDeclaration(
      UpdateCropDeclaration updateCropDeclaration, id) async {
    try {
      isLoading = true;
      notifyListeners();
      await PlantingRepository.updateQDSDeclaration(updateCropDeclaration, id);
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

  void submitCropInspection(
      AddInspection addInspection, id, bool isCrop) async {
    try {
      isLoading = true;
      notifyListeners();
      await PlantingRepository.submitInspection(addInspection, id, isCrop);
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      MethodHelpers.dioErrorHandler(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void submitCropDeclaration(AddCropDeclaration addCropDeclaration) async {
    try {
      isLoading = true;
      notifyListeners();
      await PlantingRepository.submitCropDeclaration(addCropDeclaration);
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

  void init() async {
    if (!isLoading) {
      isLoading = true;
      exception = null;
      notifyListeners();
    }
    try {
      await Future.wait([
        getCrops(),
        getCropVarieties(),
      ], eagerError: true);

      exception = null;
    } catch (e) {
      exception = e;
    }
    isLoading = false;
    notifyListeners();
  }

  void fetch(id) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      inspections = [];
      List<AssignedInpection> results =
          await PlantingRepository.getInspections(id);

      inspections.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchCropDeclarations(id) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      cropDeclarations = [];
      List<CropDeclaration> results =
          await PlantingRepository.getCropDeclaration(id);
      cropDeclarations.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchPlantingReturn(userId) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      plantingReturns = [];
      List<AssignedInpection> results =
          await PlantingRepository.getPlantingReturns(userId);

      plantingReturns.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchAssignedS10s(id) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      assignedS10s = [];
      List<Inspection> results = await PlantingRepository.getAssignedS10(id);

      assignedS10s.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }

  void fetchAssignedQDs(id) async {
    if (isLoading == false) {
      isLoading = true;
      notifyListeners();
    }
    try {
      assignedQDs = [];
      List<Inspection> results = await PlantingRepository.getAssignedQDS(id);

      assignedQDs.addAll(results);
    } catch (e) {
      exception = e;
    }

    isLoading = false;
    notifyListeners();
  }
}
