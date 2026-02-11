import 'dart:io';
import 'package:admin_app/controller/items/add_controller.dart';
import 'package:admin_app/core/function/validateinput.dart';
import 'package:admin_app/core/shared/custom_dropdownlist.dart';
import 'package:admin_app/view/widget/globalbutton.dart';
import 'package:admin_app/view/widget/globaltextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItem extends StatelessWidget {
  const AddItem({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddItemsControllerImp());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("38".tr),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildField(
              controller.nameController,
              "40".tr,
              "51".tr,
            ),
            _buildField(
              controller.arnameController,
              "41".tr,
              "52".tr,
            ),
            _buildField(
              controller.descController,
              "42".tr,
              "53".tr,
            ),
            _buildField(
              controller.ardescController,
              "43".tr,
              "54".tr,
            ),
            _buildField(
              controller.priceController,
              "44".tr,
              "55".tr,
            ),
            _buildField(
              controller.countController,
              "45".tr,
              "56".tr,
            ),
            _buildField(
              controller.discountController,
              "46".tr,
              "57".tr,
            ),
            const SizedBox(height: 12),
            CustomDropDownSearch(
              title: "47".tr,
              list: controller.dropDownList,
              selectedDropDownName: controller.catNameController,
            ),
            const SizedBox(height: 12),
            GlobalButton(
              action: "48".tr,
              onPressed: controller.pickImage,
            ),
            if (controller.pickedImage != null)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.file(
                  File(controller.pickedImage!.path),
                  fit: BoxFit.cover,
                ),
              ),
            GlobalButton(
              action: "49".tr,
              onPressed: controller.addItem,
            ),
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





