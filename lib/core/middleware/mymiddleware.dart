import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Mymiddleware extends GetMiddleware {
  Services myServices = Get.find();
  @override
  int? get priority => 1;
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("step") == "1") {
      return RouteSettings(name: appRoute.login);
    }
    if (myServices.sharedPreferences.getString("step") == "2") {
      return RouteSettings(name: appRoute.home);
    }
  }
}
