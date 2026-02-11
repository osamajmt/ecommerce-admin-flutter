import 'package:admin_app/constant/appcolor.dart';
import 'package:admin_app/controller/order/pending_controller.dart';
import 'package:admin_app/core/class/statusRequest.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';

class PendingOrdersScreen extends StatelessWidget {
  const PendingOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PendingOrdersControllerImp());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "67".tr,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<PendingOrdersControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return Center(
              child: Lottie.asset(
                'assets/lotties/loading spinner.json',
                width: 150,
              ),
            );
          }

         else if (controller.pendingOrders.isEmpty && controller.statusRequest == StatusRequest.success) {
            return Center(
              child: Text(
                "70".tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: controller.pendingOrders.length,
            itemBuilder: (context, i) {
              final order = controller.pendingOrders[i];
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
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            " #${order['id']}",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
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
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\$${order['total_price']}",
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                "79".tr,
                                Icons.delete_outline,
                                () {
                                  controller.approveOrder(order['id']);
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
          style: Theme.of(context).textTheme.bodyMedium,
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

// import 'package:admin_app/constant/appcolor.dart';
// import 'package:admin_app/controller/order/pending_controller.dart';
// import 'package:admin_app/core/class/statusRequest.dart';
// import 'package:admin_app/data/dataSource/static/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:lottie/lottie.dart';

// class PendingOrdersScreen extends StatelessWidget {
//   const PendingOrdersScreen({super.key});
//   Widget build(BuildContext context) {
//     Get.put(PendingOrdersControllerImp());
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         title: const Text("Pending Orders"),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: GetBuilder<PendingOrdersControllerImp>(
//         builder: (controller) {
//           if (controller.statusRequest == StatusRequest.loading) {
//             return Center(
//               child: Lottie.asset(
//                 'assets/lotties/loading spinner.json',
//                 width: 150,
//                 height: 150,
//               ),
//             );
//           }

//           if (controller.pendingOrders.isEmpty) {
//             return const Center(
//               child: Text(
//                 "There is no Pending orders.",
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             );
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             itemCount: controller.pendingOrders.length,
//             itemBuilder: (context, i) {
//               final order = controller.pendingOrders[i];
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 15),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.shade200,
//                       blurRadius: 8,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             "Order #${order['id']}",
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const Spacer(),
//                           Text(
//                             Jiffy(order['created_at'], 'yyyy-MM-dd').fromNow(),
//                             style: TextStyle(
//                               color: AppColor.primaryColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Divider(color: Colors.grey.shade300),
//                       const SizedBox(height: 8),
//                       _buildInfoText(
//                         "Order Type:",
//                         controller.printOrderType(order["type"]),
//                       ),
//                       _buildInfoText(
//                         "Payment:",
//                         controller.prtintPaymentMethod(order['payment_method']),
//                       ),
//                       _buildInfoText(
//                         "Status:",
//                         controller.printOrderStatus(order['status']),
//                       ),
//                       const SizedBox(height: 8),
//                       Divider(color: Colors.grey.shade300),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Total: \$${order['total_price']}",
//                             style: TextStyle(
//                               color: AppColor.primaryColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               modernButton(
//                                 "Details",
//                                 Icons.receipt_long,
//                                 () => Get.toNamed(
//                                   appRoute.orderDetails,
//                                   arguments: {"orderData": order},
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               modernButton(
//                                 "Approve",
//                                 Icons.delete_outline,
//                                 () {
//                                   controller.approveOrder(order['id']);
//                                   controller.refreshPage();
//                                 },
//                                 background: Colors.redAccent,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildInfoText(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: RichText(
//         text: TextSpan(
//           text: "$title ",
//           style: const TextStyle(color: Colors.black87, fontSize: 15),
//           children: [
//             TextSpan(
//               text: value,
//               style: const TextStyle(
//                 color: Colors.black54,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget modernButton(
//     String text,
//     IconData icon,
//     VoidCallback onPressed, {
//     Color? background,
//   }) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, size: 18, color: Colors.white),
//       label: Text(
//         text,
//         style: const TextStyle(color: Colors.white, fontSize: 14),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: background ?? AppColor.primaryColor,
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
// }
