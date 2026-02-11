import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/data/dataSource/remote/auth/logoutdata.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SettingsController extends GetxController {
  Services myServices = Get.find();
  StatusRequest? statusRequest = StatusRequest.none;
  var isDarkMode = false.obs;
  int? userId;
  String? userName;
  String? userEmail;
  String? role;
  String? image;
  void toggleTheme(bool value);
  getUserData();
  logout();
}

class SettingsControllerImp extends SettingsController {
  LogoutData logoutData = LogoutData(Get.find());
  @override
  logout() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await logoutData.logout();

    if (response is Map && response['status'] == 'success') {
   await myServices.sharedPreferences.remove("step");
   await myServices.sharedPreferences.remove("user_name");
   await myServices.sharedPreferences.remove("image");
   await myServices.sharedPreferences.remove("phone_number");

    await myServices.secureStorage.delete(key: "token");
    await myServices.secureStorage.delete(key: "user_id");
    await myServices.secureStorage.delete(key: "email");
    await myServices.secureStorage.delete(key: "role");
    
      myServices.sharedPreferences.setString("step", "1");
      Get.offAllNamed(appRoute.login);
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Error", "Logout failed");
    }

    update();
  }
  

  @override
  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  getUserData() async {
    userName = myServices.sharedPreferences.getString("user_name");
    userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
    userEmail = await myServices.secureStorage.read(key: "email");
    role = await myServices.secureStorage.read(key: "role");
    image = myServices.sharedPreferences.getString("image");
  }

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
}
