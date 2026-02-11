import 'dart:io';
import 'package:admin_app/api_link.dart';
import 'package:admin_app/controller/items/edit_controller.dart';
import 'package:admin_app/core/function/validateinput.dart';
import 'package:admin_app/core/shared/custom_dropdownlist.dart';
import 'package:admin_app/view/widget/globalbutton.dart';
import 'package:admin_app/view/widget/globaltextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditItem extends StatelessWidget {
  const EditItem({super.key});

  @override
  Widget build(BuildContext context) {
  final controller = Get.find<EditItemControllerImp>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text("39".tr), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildField(controller.nameController, "40".tr, "51".tr),
            _buildField(controller.arnameController, "41".tr, "52".tr),
            _buildField(controller.descController, "42".tr, "53".tr),
            _buildField(controller.ardescController, "43".tr, "54".tr),
            _buildField(controller.priceController, "44".tr, "55".tr),
            _buildField(controller.countController, "45".tr, "56".tr),
            _buildField(controller.discountController, "46".tr, "57".tr),
            const SizedBox(height: 12),
            CustomDropDownSearch(
              title: "47".tr,
              list: controller.dropDownList,
              selectedDropDownName: controller.catNameController,
            ),
            const SizedBox(height: 12),
            GlobalButton(action: "48".tr, onPressed: controller.pickImage),
            if (controller.pickedImage != null)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 300,
                child: Image.file(
                  File(controller.pickedImage!.path),
                  fit: BoxFit.contain,
                ),
              )
            else if (controller.imageController.text.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 300,
                child: Image.network(
                  "${AppLink.itemsImages}/${controller.imageController.text}",
                  fit: BoxFit.contain,
                  errorBuilder:
                      (_, __, ___) => const Icon(Icons.broken_image, size: 80),
                ),
              ),
            GlobalButton(action: "50".tr, onPressed: controller.editItem),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label,
    String hint,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlobalTextFormField(
        label: label,
        hintText: hint,
        icon: Icons.integration_instructions,
        controller: controller,
        isNumber: false,
        valid: (val) => validInput(val!, 3, 25, ""),
      ),
    );
  }
}


