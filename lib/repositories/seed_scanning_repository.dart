import '../Constants/stts_uganda_exports.dart';

class SeedScanningRepository {
  static Future<Trace> traceSeed(String lotNumber) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        method: 'POST',
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      var data = {
        "lot_number": lotNumber,
      };
      final response = await dio.request('trace', data: data);

      return Trace.fromJson(response.data);
    } catch (__) {
      rethrow;
    }
  }

  static Future<List<Trace>> trackSeed(String motherLot) async {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: Constants.baseUrl,
        method: 'POST',
        connectTimeout: Duration(milliseconds: Constants.timeOut),
        responseType: ResponseType.json);
    Dio dio = Dio(baseOptions);

    try {
      var data = {
        "lot_number": motherLot,
      };
      final response = await dio.request("track", data: data);

      List<Trace> traces = [];
      for (Map<String, dynamic> trace in response.data) {
        traces.add(Trace.fromJson(trace));
      }

      return traces;
    } catch (__) {
      rethrow;
    }
  }
}
