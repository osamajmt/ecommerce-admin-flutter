import 'package:admin_app/constant/appcolor.dart';
import 'package:admin_app/controller/order/beaing_prepared_controller.dart';
import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';

class BeaingPreparedOrdersScreen extends StatelessWidget {
  const BeaingPreparedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BeaingPreparedOrdersControllerImp());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text("69".tr, style: Theme.of(context).textTheme.headlineLarge,), centerTitle: true, elevation: 0),
      body: GetBuilder<BeaingPreparedOrdersControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading spinner.json',
                width: 150,
              ),
            );
          }

         else if (controller.beaingPreparedOrders.isEmpty && controller.statusRequest == StatusRequest.success) {
            return Center(
              child: Text(
                "72".tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: controller.beaingPreparedOrders.length,
            itemBuilder: (context, i) {
              final order = controller.beaingPreparedOrders[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "73".tr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            " #${order['id']}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            Jiffy(order['created_at'], 'yyyy-MM-dd').fromNow(),
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(color: Colors.grey.shade300),
                      const SizedBox(height: 8),
                      InfoText(
                        "74".tr,
                        controller.printOrderType(order["type"]),
                        context,
                      ),
                      InfoText(
                        "75".tr,
                        controller.prtintPaymentMethod(order['payment_method']),
                        context,
                      ),
                      InfoText(
                        "76".tr,
                        controller.printOrderStatus(order['status']),
                        context,
                      ),
                      const SizedBox(height: 8),
                      Divider(color: Colors.grey.shade300),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "77".tr,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                " \$${order['total_price']}",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Button(
                                "78".tr,
                                Icons.receipt_long,
                                () => Get.toNamed(
                                  appRoute.orderDetails,
                                  arguments: {"orderData": order},
                                ),
                              ),
                              const SizedBox(width: 10),
                              Button(
                                order['type'] == 1 ? "80".tr : "81".tr,
                                order['type'] == 1
                                    ? Icons.delivery_dining
                                    : Icons.check_circle,
                                () {
                                  if (order['type'] == 1) {
                                    controller.moveToDelivery(order['id']);
                                  } else {
                                    controller.finishOrder(order['id']);
                                  }
                                  controller.refreshPage();
                                },
                                background: Colors.redAccent,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget InfoText(String title, String value, dynamic context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          text: "$title ",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          children: [
            TextSpan(
              text: value,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget Button(
    String text,
    IconData icon,
    VoidCallback onPressed, {
    Color? background,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: background ?? AppColor.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
