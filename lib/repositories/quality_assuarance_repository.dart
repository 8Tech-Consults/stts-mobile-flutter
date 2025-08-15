import 'package:STTS/Constants/stts_uganda_exports.dart';
import 'package:STTS/models/import_export.dart';

class QualityRepository {
  static Future<void> submitImportPermit(
      AddQualityAssuranceForm addQualityAssuranceForm) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      await dio.post('import-export-permits', data: addQualityAssuranceForm);
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> submitExportPermit(
      AddQualityAssuranceForm addQualityAssuranceForm) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      await dio.post('import-export-permits-2', data: addQualityAssuranceForm);
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<CropVariety>> getCropVarieties() async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('crop-varieties');

      List<CropVariety> cropVarieties = [];
      for (Map<String, dynamic> cropVariety in response.data) {
        cropVarieties.add(CropVariety.fromJson(cropVariety));
      }
      return cropVarieties;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<ImportExport>> getImportPermits(int id) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('import-export-permits/$id');

      List<ImportExport> importforms = [];
      for (Map<String, dynamic> importform in response.data) {
        importforms.add(ImportExport.fromJson(importform));
      }
      return importforms;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<ImportExport>> getExportPermits(int id) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('import-export-permits-2/$id');

      List<ImportExport> importforms = [];
      for (Map<String, dynamic> importform in response.data) {
        importforms.add(ImportExport.fromJson(importform));
      }
      return importforms;
    } catch (__) {
      rethrow;
    }
  }
}
