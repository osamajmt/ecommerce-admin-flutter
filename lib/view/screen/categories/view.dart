import 'package:admin_app/controller/categories/view_controller.dart';
import 'package:admin_app/core/class/handlingdataview.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:admin_app/api_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewCategoriesControllerImp());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text("32".tr), elevation: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(appRoute.addCategory),
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<ViewCategoriesControllerImp>(
        builder:
            (controller) => Handlingdataview(
              statusRequest: controller.statusRequest,
              widget: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];

                  return InkWell(
                    onTap: () => controller.goToEditPage(category),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).shadowColor.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.network(
                              "${AppLink.categoriesImages}/${category['image']}",
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Text(
                                category['name'],
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                title: "36".tr,
                                middleText: "37".tr,
                                textConfirm: "26".tr,
                                textCancel: "27".tr,
                                confirmTextColor: Colors.white,
                                buttonColor:
                                    Theme.of(context).colorScheme.primary,
                                onConfirm: () {
                                  controller.deleteCategory(category['id']);
                                  controller.refreshPage();
                                  Get.back();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      ),
    );
  }
}
