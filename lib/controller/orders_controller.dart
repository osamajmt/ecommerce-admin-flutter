import 'package:admin_app/view/screen/orders/archived_orders_screen.dart';
import 'package:admin_app/view/screen/orders/pending_screen.dart';
import 'package:admin_app/view/screen/orders/beaing_prepared_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class OrdersController extends GetxController {
  changePage(int currentPage);
}

class OrdersControllerImp extends OrdersController {
  int currentPage = 0;
  List<Widget> pages = [
    const PendingOrdersScreen(),
    const BeaingPreparedOrdersScreen(),
     ArchivedOrdersScreen(),
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
