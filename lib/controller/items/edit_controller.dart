import 'package:admin_app/controller/items/view_controller.dart';
import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/core/function/handlingdata.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/data/dataSource/remote/categoriesdata.dart';
import 'package:admin_app/data/dataSource/remote/homedata.dart';
import 'package:admin_app/data/dataSource/remote/itemsdata.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:admin_app/data/model/itemsmodel.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class EditItemController extends GetxController {
  Services myServices = Get.find();
  ItemsData itemsData = ItemsData(Get.find());
  HomeData homeData = HomeData(Get.find());
  CategoriesData categoriesData = CategoriesData(Get.find());
  StatusRequest? statusRequest;
  List items = [];
  TextEditingController searchController = TextEditingController();
  late TextEditingController catNameController;
  late TextEditingController nameController;
  late TextEditingController arnameController;
  late TextEditingController imageController;
  late TextEditingController descController;
  late TextEditingController ardescController;
  late TextEditingController priceController;
  late TextEditingController countController;
  late TextEditingController discountController;
  String isActive = "0";
  bool? isSearch;
  List<ItemsModel> itemsSearchList = [];
  List<SelectedListItem<String>> dropDownList = [];
  List categories = [];
  initialData();
  editItem();
  pickImage();
  getCategories();
  Map? itemDetails;
  XFile? pickedImage;
}

class EditItemControllerImp extends EditItemController {
  @override
  pickImage() async {
    final ImagePicker picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imageController.text = pickedImage!.path;
      update();
    }
  }

  @override
  initialData() {}
  @override
  editItem() async {
    items.clear();
    try {
      statusRequest = StatusRequest.loading;
      print(catNameController.text);
      var response = await itemsData.editItem(
        catNameController.text,
        itemDetails!['id'].toString(),
        nameController.text,
        arnameController.text,
        descController.text,
        ardescController.text,
        priceController.text,
        countController.text,
        discountController.text,
        pickedImage?.path,
        isActive,
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
            dropDownList.add(SelectedListItem(data: categories[i]['name']));
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
  void onInit() {
    itemDetails = Get.arguments["itemDetails"];
    catNameController = TextEditingController();
    nameController = TextEditingController();
    ;
    arnameController = TextEditingController();
    ;
    imageController = TextEditingController();
    ;
    descController = TextEditingController();
    ;
    ardescController = TextEditingController();
    ;
    priceController = TextEditingController();
    ;
    countController = TextEditingController();
    ;
    discountController = TextEditingController();

    nameController.text = itemDetails!['name'] ?? "";
    arnameController.text = itemDetails!['name_ar'] ?? "";
    imageController.text = itemDetails!['image'] ?? "";
    catNameController.text = itemDetails!['category_name'].toString() ?? "";
    descController.text = itemDetails!['desc'] ?? "";
    ardescController.text = itemDetails!['desc_ar'] ?? "";
    priceController.text = itemDetails!['price'].toString() ?? "";
    countController.text = itemDetails!['count'].toString() ?? "";
    discountController.text = itemDetails!['discount'].toString() ?? "";
    imageController.text = itemDetails!['image'] ?? "";
    isActive = itemDetails!['is_active'].toString();

    getCategories();
    super.onInit();
  }
}
