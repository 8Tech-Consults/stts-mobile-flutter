import '../Constants/stts_uganda_exports.dart';

class SrformRepository {
  static Future<void> submitSr4form(
      AddApplicationForm addApplicationForm) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      await dio.post('form-sr4s', data: addApplicationForm);
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> submitSr6form(
      AddApplicationForm addApplicationForm) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      await dio.post('form-sr6s', data: addApplicationForm);
    } catch (__) {
      rethrow;
    }
  }

  static Future<void> submitQdsform(
      AddApplicationForm addApplicationForm) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      await dio.post('form-qds', data: addApplicationForm);
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<SrModel>> getSr4Model(int id) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('form-sr4s/$id');

      List<SrModel> sr4Models = [];
      for (Map<String, dynamic> itemCategoryItem in response.data) {
        sr4Models.add(SrModel.fromJson(itemCategoryItem));
      }
      return sr4Models;
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<SrModel>> getSr6Model(userId) async {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'GET',
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    );
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('form-sr6s/$userId');

      List<SrModel> sr6Models = [];
      for (Map<String, dynamic> sr6Model in response.data) {
        sr6Models.add(SrModel.fromJson(sr6Model));
      }
      return sr6Models;
    } catch (__) {
      rethrow;
    }
  }

  static Future<SrModel> getQds(int id) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        method: 'GET',
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      final response = await dio.request('form-qds/$id');
      return SrModel.fromJson(response.data);
    } catch (__) {
      rethrow;
    }
  }
}
