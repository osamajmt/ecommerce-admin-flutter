import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/core/function/handlingdata.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/data/dataSource/remote/homedata.dart';
import 'package:admin_app/data/dataSource/remote/ordersdata.dart';
import 'package:admin_app/data/model/itemsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ArchivedOrdersController extends GetxController {
  Services myServices = Get.find();
  OrderData orderData = OrderData(Get.find());
  String? userName;
  int? userId;
  StatusRequest? statusRequest;
  List settings = [];
  String? lang;
  List archivedOrders = [];
  bool? isSearch;
  initialData();
  getArchivedOrders();
}

class ArchivedOrdersControllerImp extends ArchivedOrdersController {
  HomeData homeData = HomeData(Get.find());
  @override
  initialData() async{
    lang = myServices.sharedPreferences.getString("lang");
    userName = myServices.sharedPreferences.getString('user_name');
     userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
    getArchivedOrders();
  }

  String printOrderType(int val) {
    if (val == 0) {
      return "Pick-up";
    } else {
      return "Delivery";
    }
  }

  String prtintPaymentMethod(int val) {
    if (val == 0) {
      return "Cash";
    } else {
      return "Payment card";
    }
  }

  String printOrderStatus(int val) {
    if (val == 0) {
      return "Pending";
    } else {
      return "Approved";
    }
  }

 
  @override
  getArchivedOrders() async {
    archivedOrders.clear();
    try {
      statusRequest = StatusRequest.loading;
      var response = await orderData.getArchivedOrders();
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          archivedOrders.addAll(response['orders']);
        } else {
          Get.defaultDialog(title: 'Warning', middleText: " invalid");
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = response;
        if (statusRequest == StatusRequest.serverFailure) {
          Get.defaultDialog(
            title: 'Error',
            middleText: "Server error. Please try again later.",
          );
        } else if (statusRequest == StatusRequest.offlineFailure) {
          Get.defaultDialog(
            title: 'Error',
            middleText: "No internet connection.",
          );
        }
      }
      update();
    } catch (e) {
      print("Unexpected error: $e");
      statusRequest = StatusRequest.serverException;
      Get.defaultDialog(
        title: 'Error',
        middleText: "An unexpected error occurred",
      );
    }
  }

  finishOrder(int orderId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await orderData.finishOrder(orderId);
    print("============================== $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
      } else {
        Get.defaultDialog(title: 'Warning', middleText: "invalid");
        statusRequest = StatusRequest.failure;
      }
    } else {
      statusRequest = response;
      if (statusRequest == StatusRequest.serverFailure) {
        Get.defaultDialog(
          title: 'Error',
          middleText: "Server error. Please try again later.",
        );
      } else if (statusRequest == StatusRequest.offlineFailure) {
        Get.defaultDialog(
          title: 'Error',
          middleText: "No internet connection.",
        );
      }
    }
    update();
  }
  moveToDelivery(int orderId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await orderData.moveToDelivery(orderId);
    print("============================== $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
      } else {
        Get.defaultDialog(title: 'Warning', middleText: "invalid");
        statusRequest = StatusRequest.failure;
      }
    } else {
      statusRequest = response;
      if (statusRequest == StatusRequest.serverFailure) {
        Get.defaultDialog(
          title: 'Error',
          middleText: "Server error. Please try again later.",
        );
      } else if (statusRequest == StatusRequest.offlineFailure) {
        Get.defaultDialog(
          title: 'Error',
          middleText: "No internet connection.",
        );
      }
    }
    update();
  }

  resetPageVars() {
    print("=====================reset");
    archivedOrders.clear();
  }

  refreshPage() {
    print("=====================refresh");
    resetPageVars();
    getArchivedOrders();
    update();
  }

  void onInit() {
    initialData();
    super.onInit();
  }

  
 

}
