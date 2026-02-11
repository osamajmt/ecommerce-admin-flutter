import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/core/function/handlingdata.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/data/dataSource/remote/homedata.dart';
import 'package:admin_app/data/dataSource/remote/ordersdata.dart';
import 'package:admin_app/data/model/itemsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class PendingOrdersController extends GetxController {
  Services myServices = Get.find();
  OrderData orderData = OrderData(Get.find());
  String? userName;
  int? userId;
  StatusRequest? statusRequest;
  List settings = [];
  String? lang;
  List pendingOrders = [];
  TextEditingController searchController = TextEditingController();
  bool? isSearch;
  int? deliveryId;
  List<ItemsModel> itemsSearchList = [];
  initialData();
  getSettings();
  checkSearch();
  onItemsSearch();
  getPendingOrders();
  approveOrder(int orderId);
}

class PendingOrdersControllerImp extends PendingOrdersController {
  HomeData homeData = HomeData(Get.find());
  @override
  initialData() async {
    lang = myServices.sharedPreferences.getString("lang");
    userName = myServices.sharedPreferences.getString('user_name');
    // userId = myServices.sharedPreferences.getInt('id');
    userId = int.parse(
      await myServices.secureStorage.read(key: "user_id") ?? "0",
    );
    print("=================deliery_id=====${userId}");
    getPendingOrders();
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
  getSettings() async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await homeData.getSettings();
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          settings.addAll(response['settings']);
          myServices.sharedPreferences.setString(
            "deliveryTime",
            settings[0]['delivery_time'],
          );
        } else {
          Get.defaultDialog(
            title: 'Warning',
            middleText: " Email or Password is not valid",
          );
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

  @override
  getPendingOrders() async {
    statusRequest = StatusRequest.loading;
    update();
    pendingOrders.clear();
    try {
      statusRequest = StatusRequest.loading;
      print(1);
      var response = await orderData.getPendingOrders();
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          pendingOrders.addAll(response['orders']);
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

  @override
  approveOrder(int orderId) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await orderData.approveOrder(orderId);
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
    pendingOrders.clear();
  }

  refreshPage() {
    print("=====================refresh");
    resetPageVars();
    getPendingOrders();
    update();
  }

  void onInit() {
    initialData();
    super.onInit();
  }

  @override
  checkSearch() {
    if (searchController.text == "") {
      statusRequest = StatusRequest.none;
      isSearch = false;
    }
  }

  @override
  onItemsSearch() {
    isSearch = true;
    update();
  }
  
}
