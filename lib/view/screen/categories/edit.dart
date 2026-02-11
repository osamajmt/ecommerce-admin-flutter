import 'dart:io';
import 'package:admin_app/api_link.dart';
import 'package:admin_app/controller/categories/edit_controller.dart';
import 'package:admin_app/core/class/handlingdataview.dart';
import 'package:admin_app/core/function/validateinput.dart';
import 'package:admin_app/view/widget/globalbutton.dart';
import 'package:admin_app/view/widget/globaltextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditCategory extends StatelessWidget {
  const EditCategory({super.key});

  @override
  Widget build(BuildContext context) {
   Get.find<EditCategoryControllerImp>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("60".tr),
        elevation: 0,
      ),
      body: GetBuilder<EditCategoryControllerImp>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.formstate,
              child: ListView(
                children: [
                  GlobalTextFormField(
                    label: "61".tr,
                    hintText: "63".tr,
                    icon: Icons.category,
                    controller: controller.nameController,
                    isNumber: false,
                    valid: (val) => validInput(val!, 3, 25, ""),
                  ),
                  const SizedBox(height: 12),
                  GlobalTextFormField(
                    label: "62".tr,
                    hintText: "64".tr,
                    icon: Icons.category,
                    controller: controller.arnameController,
                    isNumber: false,
                    valid: (val) => validInput(val!, 3, 25, ""),
                  ),
                 if (controller.pickedImage != null)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    height: 150,
                    child: Image.file(
                      File(controller.pickedImage!.path),
                      fit: BoxFit.cover,
                    ),
                  )
                  else if (controller.imageController.text.isNotEmpty) 
                   Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    height: 150,
                    child: controller.imageController.text.endsWith('.svg')
                        ? SvgPicture.network(
                            "${AppLink.categoriesImages}/${controller.imageController.text}",
                            fit: BoxFit.contain,
                            placeholderBuilder: (_) =>
                                const Center(child: CircularProgressIndicator()),
                          )
                        : Image.network(
                            "${AppLink.categoriesImages}/${controller.imageController.text}",
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image, size: 80),
                          ),
                  ),
                  GlobalButton(
                    action: "65".tr,
                    onPressed: controller.pickImage,
                  ),
                  const SizedBox(height: 12),
                  GlobalButton(
                    action: "50".tr,
                    onPressed: controller.editCategory,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}







