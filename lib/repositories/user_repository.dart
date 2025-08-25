import 'package:dio/dio.dart'; // Use this instead of dio_http
import 'package:STTS/models/add_user.dart';
import 'package:STTS/models/user.dart';

import '../Constants/constants.dart';

class UserRepository {
  // Create a single, reusable Dio instance
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: Duration(milliseconds: Constants.timeOut),
      responseType: ResponseType.json,
    ),
  );

  // A private method to handle Dio exceptions gracefully
  _handleDioException(DioException e) {
    String errorMessage = "An unknown error occurred1.";
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = "Network connection timed out.";
        break;
      case DioExceptionType.badResponse:
        errorMessage = "Server error: ${e.response?.statusCode}";
        if (e.response?.data != null && e.response?.data is Map) {
          final message = e.response?.data['message'];
          if (message != null) {
            errorMessage = message;
          }
        }
        break;
      case DioExceptionType.cancel:
        errorMessage = "Request was cancelled.";
        break;
      case DioExceptionType.unknown:
        errorMessage = "No internet connection detected.";
        break;
      default:
        errorMessage = "Something went wrong.";
    }
    // Re-throw with a more descriptive message
    throw Exception(errorMessage);
  }

  static Future<User> login(String username, String password) async {
    final dio = UserRepository()._dio;
    try {
      final response = await dio.post(
        'login',
        data: {'username': username, 'password': password},
      );
      // Assuming response.data['data'] is the user JSON
      return User.fromJson(response.data['data']);
    } on DioException catch (e) {
      // Catch Dio-specific errors and rethrow with a custom message
      UserRepository()._handleDioException(e);
      // This line is for static analysis, it will not be reached
      throw Exception('Login failed');
    }
  }
  

  /* static Future<void> register(AddUser addUser) async {
    final dio = UserRepository()._dio;
    try {
      // Use dio.post() for POST requests; it's more expressive than dio.request()
      final response = await dio.post('register', data: addUser.toJson());
      // print("Response: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      // Catch Dio-specific errors and rethrow with a custom message
      UserRepository()._handleDioException(e);
    }

  } */
 static Future<ApiResponse> register(AddUser addUser) async {
  final dio = UserRepository()._dio;
  try {
    final response = await dio.post(
      'register',
      data: addUser.toJson(),
      options: Options(
        headers: {'Content-Type': 'application/json'}, // ensure JSON
      ),
    );

    // Strong checks
    final status = response.statusCode ?? 0;
    if (status < 200 || status >= 300) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: 'HTTP $status',
      );
    }

    // Parse your API’s contract
    final body = response.data;
    if (body is Map<String, dynamic>) {
      return ApiResponse.fromJson(body);
    } else {
      // If your API returns plain text or something else
      return ApiResponse(success: true, message: 'OK', data: body);
    }
  } on DioException catch (e) {
    UserRepository()._handleDioException(e);
    rethrow; // important: propagate to caller
  }
}

}


class ApiResponse {
  final bool success;
  final String message;
  final dynamic data;
  ApiResponse({required this.success, required this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    success: json['success'] == true,            // be strict
    message: (json['message'] ?? '').toString(),
    data: json['data'],
  );
}
