import 'dart:io';
import 'package:admin_app/controller/home_controller.dart';
import 'package:admin_app/view/widget/customappbarbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());

    return GetBuilder<HomeControllerImp>(
      builder:
          (controller) => Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,

            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: BottomAppBar(
                elevation: 0,
                color: Colors.transparent,
                shape: const CircularNotchedRectangle(),
                notchMargin: 8,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomAppBarButton(
                      icon: Icons.home,
                      isActive: controller.currentPage == 0,
                      onPressed: () => controller.changePage(0),
                    ),
                    CustomAppBarButton(
                      icon: Icons.notifications,
                      isActive: controller.currentPage == 1,
                      onPressed: () => controller.changePage(1),
                    ),
                    CustomAppBarButton(
                      icon: Icons.settings,
                      isActive: controller.currentPage == 2,
                      onPressed: () => controller.changePage(2),
                    ),
                  ],
                ),
              ),
            ),

            body: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) {
                  Get.defaultDialog(
                    title: "24".tr,
                    middleText: "25".tr,
                    confirmTextColor: Colors.white,
                    buttonColor: Get.theme.primaryColor,
                    textConfirm: "26".tr,
                    textCancel: "27".tr,
                    onConfirm: () => exit(0),
                    onCancel: Get.back,
                  );
                }
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: controller.pages[controller.currentPage],
              ),
            ),
          ),
    );
  }
}
