import 'package:admin_app/controller/items/view_controller.dart';
import 'package:admin_app/core/class/handlingdataview.dart';
import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:admin_app/api_link.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewItemsControllerImp());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text("58".tr), elevation: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(appRoute.addItem),
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<ViewItemsControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading spinner.json',
                width: 150,
                height: 150,
                repeat: true,
              ),
            );
          } else if (controller.items.isEmpty &&controller.statusRequest == StatusRequest.success) {
            return Center(
              child: Text(
                "88".tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          return Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                final item = controller.items[index];

                return InkWell(
                  onTap: () => controller.goToEditPage(item),
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
                          child: Image.network(
                            "${AppLink.itemsImages}/${item['image']}",
                            fit: BoxFit.cover,
                            cacheWidth: 200,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image_not_supported,
                                size: 40,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['category_name'],
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
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
                              middleText: "66".tr,
                              textConfirm: "26".tr,
                              textCancel: "27".tr,
                              confirmTextColor: Colors.white,
                              buttonColor:
                                  Theme.of(context).colorScheme.primary,
                              onConfirm: () {
                                controller.deleteItem(item['id']);
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
          );
        },
      ),
    );
  }
}
