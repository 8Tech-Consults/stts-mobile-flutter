import 'dart:convert';
import 'package:STTS/helpers/helpers.dart';
import 'package:STTS/models/add_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../screens/account/login_screen.dart';
import '../screens/home_screen.dart';

class UserController extends ChangeNotifier {
  SharedPreferences? sharedPreferences;
  bool isLoggedIn = false;
  bool loading = false;
  User? user;

  // A more robust way to handle initialization
  Future<void> init() async {
    // Initialize SharedPreferences only once
    sharedPreferences = await SharedPreferences.getInstance();
    String? userJson = sharedPreferences?.getString('user');
    if (userJson != null) {
      user = User.fromJson(jsonDecode(userJson));
      isLoggedIn = true;
    }
    notifyListeners();
  }

  Future<void> registerUser(AddUser addUser) async {
    loading = true;
    notifyListeners();

    try {
      await UserRepository.register(addUser);
      MethodHelpers.showSuccessWithNoActionButton("User registered successfully");
    } catch (e) {
      MethodHelpers.dioErrorHandler(e);
    }
    
    loading = false;
    notifyListeners();
  }

  /* Future<void> registerUser(AddUser addUser) async {
    loading = true;
    notifyListeners();

    try {
      final res = await UserRepository.register(addUser);

      if (res.success) {
        MethodHelpers.showSuccessWithNoActionButton("User registered successfully");
      } else {
        // Show server-provided reason
        MethodHelpers.showErrorBarWithNoActionButton(res.message.isNotEmpty ? res.message : "Registration failed");
      }
    } catch (e) {
      MethodHelpers.dioErrorHandler(e); // shows network/HTTP errors
    } finally {
      loading = false;
      notifyListeners();
    }
  } */


  void login(String username, String password) async {
    loading = true;
    notifyListeners();
    
    try {
      User userResult = await UserRepository.login(username, password);
      isLoggedIn = true;
      user = userResult;

      // Ensure sharedPreferences is initialized before use
      sharedPreferences ??= await SharedPreferences.getInstance();
      sharedPreferences?.setString('user', jsonEncode(user));
      
      Get.to(() => const HomeScreen());
    } catch (err) {
      MethodHelpers.dioErrorHandler(err, isAcctBassed: true);
    }

    loading = false;
    notifyListeners();
  }

  void logOut() async {
    // Use the stored sharedPreferences instance if available
    sharedPreferences ??= await SharedPreferences.getInstance();
    await sharedPreferences?.clear();
    isLoggedIn = false;
    user = null;
    Get.offAll(() => LoginScreen());
    notifyListeners();
  }
}