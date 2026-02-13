import 'package:admin_app/controller/categories/edit_controller.dart';
import 'package:get/get.dart';
class EditCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditCategoryControllerImp>(() => EditCategoryControllerImp());
  }
}