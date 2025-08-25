import 'dart:io';

import 'package:STTS/utils/my_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MethodHelpers {
  int columnsForWidth(double w) {
    if (w >= 1200) return 4;
    if (w >= 900)  return 3;
    if (w >= 600)  return 2;
    return 1;
  }

  static void showErrorBarWithNoActionButton(String message,
      {SnackPosition snackPosition = SnackPosition.BOTTOM}) {
    Get.showSnackbar(GetBar(
      message: message,
      duration: const Duration(seconds: 5),
      isDismissible: true,
      snackPosition: snackPosition,
      margin: const EdgeInsets.only(left: 10, right: 10),
      backgroundColor: Color(0xffBA5965),
    ));
  }

  static void showSuccessWithNoActionButton(String message,
      {SnackPosition snackPosition = SnackPosition.BOTTOM}) {
    Get.showSnackbar(GetBar(
      message: message,
      duration: const Duration(seconds: 5),
      isDismissible: true,
      snackPosition: snackPosition,
      margin: const EdgeInsets.only(left: 10, right: 10),
      backgroundColor: MyColors.primary,
    ));
  }

//method to execute a url in the broswer
  static openUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw Exception();
      }
    } catch (_) {
      MethodHelpers.showErrorBarWithNoActionButton(
          "Couldn't load this page due to unexpected error");
    }
  }
  

  static void dioErrorHandler(dynamic err, {bool isAcctBassed = false}) {
    try {
      /* if (err is DioError) {
        switch (err.type) {
          case DioErrorType.connectTimeout:
            MethodHelpers.showErrorBarWithNoActionButton(
                "Network Connection timedout");
            break;
          case DioErrorType.sendTimeout:
            MethodHelpers.showErrorBarWithNoActionButton(
                "Network Connection timedout");
            break;
          case DioErrorType.receiveTimeout:
            MethodHelpers.showErrorBarWithNoActionButton(
                "Server Response Connection timedout");
            break;
          case DioErrorType.response:
            var response = err.response?.data;
            if (err.response?.statusCode == 401) {
              if (response != null && response['message'] != null) {
                MethodHelpers.showErrorBarWithNoActionButton(
                    response['message']);
              } else {
                MethodHelpers.showErrorBarWithNoActionButton(
                    "Oops, an error occured while processing your request");
              }
            } else if (err.response?.statusCode == 400 ||
                err.response?.statusCode == 404 ||
                err.response?.statusCode == 422) {
              if (response != null && response['errors'] != null) {
                Map data = response['errors'];

                List<dynamic> values = data.entries.first.value;

                MethodHelpers.showErrorBarWithNoActionButton(values[0]);
              } else {
                if (response != null && response['message'] != null) {
                  MethodHelpers.showErrorBarWithNoActionButton(
                      response['message']);
                } else {
                  MethodHelpers.showErrorBarWithNoActionButton(
                      "Oops, an error occured while processing your request");
                }
              }
            } else if (err.response?.statusCode == 409) {
              if (isAcctBassed) {
                MethodHelpers.showErrorBarWithNoActionButton(
                    "User with the same email already exists. Please proceed to login instead");
              } else {
                MethodHelpers.showErrorBarWithNoActionButton(
                    response['message']);
              }
            } else {
              MethodHelpers.showErrorBarWithNoActionButton(
                  "Oops, an Unknown error occured.");
            }
            break;
          case DioErrorType.cancel:
            MethodHelpers.showErrorBarWithNoActionButton(
                "Connection was cancelled");
            break;
          case DioErrorType.other:
            if (err.error is SocketException) {
              MethodHelpers.showErrorBarWithNoActionButton(
                  "No internet connection detected");
            } else {
              MethodHelpers.showErrorBarWithNoActionButton(
                  "Oops, an Unknown error occured");
            }
            break;
        }
        return;
      }  */
      
      if (err is DioException) { // Use DioException
    String errorMessage = "Oops, an Unknown error occurred 1.";

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        errorMessage = "Network connection timed out.";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Server response timed out.";
        break;
      case DioExceptionType.badResponse:
        final response = err.response;
        final statusCode = response?.statusCode;
        final responseData = response?.data;

        if (statusCode == 401) {
          if (responseData != null && responseData['message'] != null) {
            errorMessage = responseData['message'];
          } else {
            errorMessage = "Unauthorized access.";
          }
        } else if (statusCode == 400 || statusCode == 404 || statusCode == 422) {
          if (responseData != null && responseData['errors'] != null) {
            Map data = responseData['errors'];
            if (data.isNotEmpty) {
              List<dynamic> values = data.values.first;
              if (values.isNotEmpty) {
                errorMessage = values[0].toString();
              }
            }
          } else if (responseData != null && responseData['message'] != null) {
            errorMessage = responseData['message'];
          } else {
            errorMessage = "Bad request, check your inputs.";
          }
        } else if (statusCode == 409) {
          if (isAcctBassed) {
            errorMessage = "User with the same email already exists. Please log in.";
          } else if (responseData != null && responseData['message'] != null) {
            errorMessage = responseData['message'];
          }
        } else {
          errorMessage = "Oops, an error occurred on the server.";
        }
        break;
      case DioExceptionType.cancel:
        errorMessage = "Request was cancelled.";
        break;
      case DioExceptionType.unknown:
        if (err.error is SocketException) {
          errorMessage = "No internet connection detected.";
        }
        break;
      default:
        // Handles new types gracefully
        break;
    }

    MethodHelpers.showErrorBarWithNoActionButton(errorMessage);
  }else {
        MethodHelpers.showErrorBarWithNoActionButton(
            "Oops, an Unknown error occured.");
      }
    } catch (_) {
      MethodHelpers.showErrorBarWithNoActionButton(
          "Oops, failed processing your request. Please retry");
    }
  }
}
