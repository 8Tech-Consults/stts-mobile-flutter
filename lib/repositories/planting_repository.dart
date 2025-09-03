import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/models/add_crop_declaration.dart';
import 'package:STTS/models/add_inspection.dart';
import 'package:STTS/models/add_planting_return.dart';
import 'package:STTS/models/add_seed_lab.dart';
import 'package:STTS/models/assigned_sub_grower.dart';
import 'package:STTS/models/crop.dart';
import 'package:STTS/models/crop_declaration.dart';
import 'package:STTS/models/inspection.dart';
// import 'package:STTS/models/planting_returns.dart';
import 'package:STTS/models/updateCropDeclaration.dart';
import 'package:STTS/models/update_planting_return.dart';

class PlantingRepository {
  static Future<List<AssignedInpection>> getPlantingReturns(userId) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('sub-growers/$userId');

      List<AssignedInpection> plantingReturns = [];
      for (Map<String, dynamic> plantingReturn in response.data) {
        plantingReturns.add(AssignedInpection.fromJson(plantingReturn));
      }

      return plantingReturns;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<Crop>> getCrops() async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('crops');

      List<Crop> crops = [];
      for (Map<String, dynamic> crop in response.data) {
        crops.add(Crop.fromJson(crop));
      }

      return crops;
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> submitInspection(
    AddInspection addInspection,
    id,
    bool isCrop,
  ) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      var url = isCrop ? 'qds-crop-inspection-2' : 'form-sr10s';
      await dio.put(
        '$url/$id',
        data: addInspection.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> submitPlantingReturn(
    AddPlantingReturn addPlantingReturn,
  ) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);
    debugPrint(jsonEncode(addPlantingReturn.toJson()));
    try {
      // await dio.post('sub-growers', data: addPlantingReturn);
      await dio.post(
        'sub-growers',
        data: addPlantingReturn.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> submitSeedLabs(AddSeedLab addSeedLab) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      await dio.post('seed-labs', data: addSeedLab);
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> submitCropDeclaration(
    AddCropDeclaration addCropDeclaration,
  ) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      await dio.post(
        'form-crop-declarations',
        data: addCropDeclaration.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> updatePlantingReturn(
    UpdatePlantingReturn updatePlantingReturn,
    id,
  ) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      await dio.put(
        'sub-growers/$id',
        data: updatePlantingReturn.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> updateQDSDeclaration(
    UpdateCropDeclaration updateCropDeclaration,
    id,
  ) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      await dio.put('form-crop-declarations/$id', data: updateCropDeclaration);
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<AssignedInpection>> getInspections(int id) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      var url = locator<UserController>().user?.roles[0].name == "Basic User"
          ? 'sub-growers'
          : 'assigned-sub-growers';
      final response = await dio.request('$url/$id');

      List<AssignedInpection> inspections = [];
      for (Map<String, dynamic> inspection in response.data) {
        inspections.add(AssignedInpection.fromJson(inspection));
      }

      return inspections;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<CropDeclaration>> getCropDeclaration(int id) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      var url = locator<UserController>().user?.roles[0].name == "Basic User"
          ? 'form-crop-declarations'
          : 'assigned-form-crop-declarations';
      final response = await dio.request('$url/$id');

      List<CropDeclaration> cropDeclarations = [];
      for (Map<String, dynamic> cropDeclaration in response.data) {
        cropDeclarations.add(CropDeclaration.fromJson(cropDeclaration));
      }

      return cropDeclarations;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<Inspection>> getAssignedS10(id) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      var url = locator<UserController>().user?.roles[0].name == "Basic User"
          ? 'form-sr10s'
          : 'assigned-sr10s';
      final response = await dio.request('$url/$id');

      List<Inspection> assignedS10s = [];
      for (Map<String, dynamic> assignedS10 in response.data) {
        assignedS10s.add(Inspection.fromJson(assignedS10));
      }

      return assignedS10s;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<Inspection>> getAssignedQDS(id) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      var url = 'assigned-qds-inspection';
      final response = await dio.request('$url/$id');

      List<Inspection> assignedQDs = [];
      for (Map<String, dynamic> assignedQD in response.data) {
        assignedQDs.add(Inspection.fromJson(assignedQD));
      }

      return assignedQDs;
    } catch (__) {
      rethrow;
    }
  }
}
