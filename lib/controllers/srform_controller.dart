import 'package:STTS/helpers/helpers.dart';
import 'package:STTS/models/add_application_form.dart';
import 'package:STTS/models/crop.dart';
import 'package:STTS/repositories/planting_repository.dart';
import 'package:STTS/repositories/srform_repository.dart';

import '../Constants/stts_uganda_exports.dart';

class SrFormController extends ChangeNotifier {
  bool isLoading = false;
  dynamic exception;
  bool submitSuccess = false;
  List<SrModel> sr4Models = [];
  List<SrModel> sr6Models = [];
  SrModel? qdsModel;
  List<Crop> crops = [];

  Future getCrops() async {
    try {
      crops = [];
      List<Crop> results = await PlantingRepository.getCrops();

      crops.addAll(results);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future setQds(int id) async {
    try {
      List<dynamic> results = await Future.wait([
        SrformRepository.getQds(id),
      ], eagerError: true);
      qdsModel = results[0];
    } catch (__) {
      rethrow;
    }
  }

  Future fetchSr4Forms(int id) async {
    try {
      sr4Models = [];
      List<SrModel> results = await SrformRepository.getSr4Model(id);

      sr4Models.addAll(results);
    } catch (e) {
      rethrow;
    }
  }

  Future getSr6Forms(userId) async {
    try {
      sr6Models = [];
      List<SrModel> results = await SrformRepository.getSr6Model(userId);

      sr6Models.addAll(results);
    } catch (e) {
      rethrow;
    }
  }

  void submitSr4Form(AddApplicationForm addApplicationForm) async {
    try {
      isLoading = true;
      notifyListeners();
      await SrformRepository.submitSr4form(addApplicationForm);
      isLoading = false;
      notifyListeners();
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      MethodHelpers.showErrorBarWithNoActionButton(
          "You cannot create a new SR4 form  while having PENDING one of the same category");
    }

    isLoading = false;
    notifyListeners();
  }

  void submitSr6Form(AddApplicationForm addApplicationForm) async {
    try {
      isLoading = true;
      notifyListeners();
      await SrformRepository.submitSr6form(addApplicationForm);
      isLoading = false;
      notifyListeners();
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      if (e is DioError) {
        // print("akkakakkkllak:${e.response}");
      }
      // MethodHelpers.showErrorBarWithNoActionButton(
      //     "You cannot create a new SR4 form  while having PENDING one of the same category");
    }

    isLoading = false;
    notifyListeners();
  }

  void submitQdsForm(AddApplicationForm addApplicationForm) async {
    try {
      isLoading = true;
      notifyListeners();
      await SrformRepository.submitQdsform(addApplicationForm);
      isLoading = false;
      notifyListeners();
      MethodHelpers.showSuccessWithNoActionButton(
          "Thank you for your submission");
    } catch (e) {
      if (e is DioError) {
        print("ooall:${e.response}");
      }
      // MethodHelpers.showErrorBarWithNoActionButton(
      //     "You cannot create a new SR4 form  while having PENDING one of the same category");
    }

    isLoading = false;
    notifyListeners();
  }

  void init(id) async {
    if (!isLoading) {
      isLoading = true;
      exception = null;
      notifyListeners();
    }
    try {
      await Future.wait([
        fetchSr4Forms(id),
      ], eagerError: true);

      exception = null;
    } catch (e) {
      exception = e;
    }
    isLoading = false;
    notifyListeners();
  }

  void fetchSr6Forms(userId) async {
    if (!isLoading) {
      isLoading = true;
      exception = null;
      notifyListeners();
    }
    try {
      await Future.wait([
        getSr6Forms(userId),
      ], eagerError: true);

      exception = null;
    } catch (e) {
      exception = e;
    }
    isLoading = false;
    notifyListeners();
  }

  void fetchQdsForm(id) async {
    if (!isLoading) {
      isLoading = true;
      exception = null;
      notifyListeners();
    }
    try {
      await Future.wait([
        setQds(id),
      ], eagerError: true);

      exception = null;
    } catch (e) {
      exception = e;
    }
    isLoading = false;
    notifyListeners();
  }
}
