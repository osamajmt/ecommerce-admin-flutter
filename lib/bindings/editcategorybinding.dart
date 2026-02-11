import 'package:admin_app/controller/items/edit_controller.dart';
import 'package:get/get.dart';
class EditCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditItemControllerImp>(() => EditItemControllerImp());
  }
}