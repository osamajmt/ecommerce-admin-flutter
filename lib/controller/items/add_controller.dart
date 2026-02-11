import 'package:admin_app/controller/items/view_controller.dart';
import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/core/function/handlingdata.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/data/dataSource/remote/categoriesdata.dart';
import 'package:admin_app/data/dataSource/remote/itemsdata.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class AddItemsController extends GetxController {
  Services myServices = Get.find();
  ItemsData itemsData = ItemsData(Get.find());
  CategoriesData categoriesData = CategoriesData(Get.find());
  StatusRequest? statusRequest;
  late TextEditingController catNameController;
  // late TextEditingController catIdController;
  late TextEditingController nameController;
  late TextEditingController arnameController;
  late TextEditingController descController;
  late TextEditingController ardescController;
  late TextEditingController priceController;
  late TextEditingController countController;
  late TextEditingController discountController;
  XFile? pickedImage;
  List<SelectedListItem<String>> dropDownList = [];
  pickImage();
  List items = [];
  List categories = [];
  showDropDownList();
  addItem();
}

class AddItemsControllerImp extends AddItemsController {
  @override
  pickImage() async {
    final ImagePicker picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
       pickedImage!.path;
      update();
    }
  }
  @override
  addItem() async {
    try {
      statusRequest = StatusRequest.loading;
      print(1);
      var response = await itemsData.addItem(
        catNameController.text,
        nameController.text,
        arnameController.text,
        descController.text,
        ardescController.text,
        priceController.text,
        countController.text,
        discountController.text,
         pickedImage!.path,
      );
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          ViewItemsControllerImp viewController = Get.find();
          viewController.getItems();
          Get.toNamed(appRoute.items);
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
          for (int i = 0; i < categories.length; i++) {
            dropDownList.add(SelectedListItem(data:categories[i]['name']));
          }
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
  showDropDownList() {}
  @override
  void onInit() {
    catNameController = TextEditingController();
    nameController = TextEditingController();
    arnameController = TextEditingController();
    descController = TextEditingController();
    ardescController = TextEditingController();
    countController = TextEditingController();
    priceController = TextEditingController();
    discountController = TextEditingController();
    getCategories();
    super.onInit();
  }
}
