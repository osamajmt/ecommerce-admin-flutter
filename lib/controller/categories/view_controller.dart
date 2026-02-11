import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/core/function/handlingdata.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/data/dataSource/remote/categoriesdata.dart';
import 'package:admin_app/data/dataSource/remote/homedata.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:admin_app/data/model/itemsmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ViewCategoriesController extends GetxController {
  Services myServices = Get.find();
  CategoriesData categoriesData = CategoriesData(Get.find());
  StatusRequest? statusRequest;
  List categories = [];
  deleteCategory(int catId);
  goToEditPage(Map category);
}

class ViewCategoriesControllerImp extends ViewCategoriesController {
  HomeData homeData = HomeData(Get.find());

  getCategories() async {
    categories.clear();
    update();
    try {
      statusRequest = StatusRequest.loading;
      print(1);
      var response = await categoriesData.getCategories();
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          categories.addAll(response['categories']);
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
      print("Unexpected Error: $e");
      statusRequest = StatusRequest.serverException;
      Get.defaultDialog(
        title: 'Error',
        middleText: "An unexpected error occurred",
      );
    }
  }

  @override
  deleteCategory(int catId) async {
    try {
      statusRequest = StatusRequest.loading;
      var response = await categoriesData.deleteCategory(catId);
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

  resetPageVars() {
    print("=====================reset");
    categories.clear();
  }

  refreshPage() {
    print("=====================refresh");
    resetPageVars();
    getCategories();
    update();
  }

  @override
  goToEditPage(Map category) {
    Get.toNamed(
      appRoute.editCategory,
      arguments: {"categoryDetails": category},
    );
  }


  void onInit() {
    getCategories();
    super.onInit();
  }
}
