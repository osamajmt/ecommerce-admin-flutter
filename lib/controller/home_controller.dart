import 'package:admin_app/view/screen/home_screen.dart';
import 'package:admin_app/view/screen/notifications_screen.dart';
import 'package:admin_app/view/screen/settings_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {
  changePage(int currentPage);
}

class HomeControllerImp extends HomeController {
  int currentPage = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const NotificationsScreen(),
    const Settings(),
  ];
  @override
  changePage(int i) {
    currentPage = i;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
