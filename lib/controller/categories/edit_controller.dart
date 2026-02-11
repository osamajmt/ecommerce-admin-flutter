import 'package:admin_app/controller/categories/view_controller.dart';
import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/core/function/handlingdata.dart';
import 'package:admin_app/core/services/services.dart';
import 'package:admin_app/data/dataSource/remote/categoriesdata.dart';
import 'package:admin_app/data/dataSource/remote/homedata.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class EditCategoryController extends GetxController {
  Services myServices = Get.find();
  CategoriesData categoriesData = CategoriesData(Get.find());
  StatusRequest? statusRequest;
  late TextEditingController nameController;
  late TextEditingController arnameController;
  late TextEditingController imageController;
  List categories = [];
  XFile? pickedImage;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  Map? categoryDetails;
  editCategory();
  pickImage();
}

class EditCategoryControllerImp extends EditCategoryController {
  HomeData homeData = HomeData(Get.find());
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
  editCategory() async {
    var formdata = formstate.currentState;
    try {
        if (formdata!.validate()) {
          statusRequest = StatusRequest.loading;
          var response = await categoriesData.editCategory(
            categoryDetails!['id'].toString(),
            nameController.text,
            arnameController.text,
            pickedImage?.path,
          );
          print("============================== $response");
          statusRequest = handlingData(response);
          if (StatusRequest.success == statusRequest) {
            if (response['status'] == "success") {
              ViewCategoriesControllerImp viewController = Get.find();
              viewController.getCategories();
              Get.toNamed(appRoute.categories);
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
  void onInit() {
    categoryDetails = Get.arguments["categoryDetails"];
    nameController = TextEditingController();
    arnameController = TextEditingController();
    imageController = TextEditingController();
    nameController.text = categoryDetails!['name'] ?? "";
    arnameController.text = categoryDetails!['name_ar'] ?? "";
    imageController.text = categoryDetails!['image'] ?? "";
    super.onInit();
  }
}
