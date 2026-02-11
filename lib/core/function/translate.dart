import 'package:admin_app/core/services/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

translate(arColumn, enColumn) {
  Services myServices = Get.find();
  if (myServices.sharedPreferences.getString("lang") == "ar") {
    return arColumn;
  } else {
    return enColumn;
  }
}
