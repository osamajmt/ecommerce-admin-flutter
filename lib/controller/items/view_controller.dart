import 'package:admin_app/api_link.dart';
import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/core/function/handlingdata.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/data/dataSource/remote/homedata.dart';
import 'package:admin_app/data/dataSource/remote/itemsdata.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:admin_app/data/model/itemsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ViewItemsController extends GetxController {
  Services myServices = Get.find();
  ItemsData itemsData = ItemsData(Get.find());
  StatusRequest? statusRequest;
  List items = [];
  TextEditingController searchController = TextEditingController();
  bool? isSearch;
  List<ItemsModel> itemsSearchList = [];
  checkSearch();
  deleteItem(int itemId);
  goToEditPage(Map itemDetails);
}

class ViewItemsControllerImp extends ViewItemsController {
  HomeData homeData = HomeData(Get.find());

  getItems() async {
    items.clear();
    try {
      statusRequest = StatusRequest.loading;
      print(1);
      var response = await itemsData.getItems();
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          items.addAll(response['items']);
          print(items);
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
      for (var item in items) {
        precacheImage(
          NetworkImage("${AppLink.itemsImages}/${item['image']}"),
          Get.context!,
        );
      }
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
  deleteItem(int itemId) async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await itemsData.deleteItem(itemId);
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          refreshPage();
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
        update();
      }
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
  checkSearch() {
    if (searchController.text == "") {
      statusRequest = StatusRequest.none;
      isSearch = false;
    }
  }

  @override
  goToEditPage(Map itemDetails) {
    Get.toNamed(appRoute.editItem, arguments: {"itemDetails": itemDetails});
  }

  resetPageVars() {
    print("=====================reset");
    items.clear();
  }

  refreshPage() {
    print("=====================refresh");
    resetPageVars();
    getItems();
    update();
  }

  void onInit() {
    getItems();
    super.onInit();
  }
}
