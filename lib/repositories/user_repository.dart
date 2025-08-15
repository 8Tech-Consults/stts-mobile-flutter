import 'package:dio/dio.dart'; // Use this instead of dio_http
import 'package:STTS/models/add_user.dart';
import 'package:STTS/models/user.dart';

import '../Constants/constants.dart';

class UserRepository {
  // Create a single, reusable Dio instance
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Constants.baseUrl,
    connectTimeout: Duration(milliseconds: Constants.timeOut),
    responseType: ResponseType.json,
  ));

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

  static Future<User> login(
    String username,
    String password,
  ) async {
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

  static Future<void> register(AddUser addUser) async {
    final dio = UserRepository()._dio;
    try {
      // Use dio.post() for POST requests; it's more expressive than dio.request()
      await dio.post('register', data: addUser);
    } on DioException catch (e) {
      // Catch Dio-specific errors and rethrow with a custom message
      UserRepository()._handleDioException(e);
    }
  }
}