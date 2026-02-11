import 'package:admin_app/constant/imageasset.dart';
import 'package:admin_app/data/dataSource/static/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("31".tr, style: Theme.of(context).textTheme.headlineLarge),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
          children: [
            buildHomeCard(
              context: context,
              title: "32".tr,
              icon: ImageAsset.categories,
              onTap: () => Get.toNamed(appRoute.categories),
            ),
            buildHomeCard(
              context: context,
              title: "33".tr,
              icon: ImageAsset.items,
              onTap: () => Get.toNamed(appRoute.items),
            ),
            buildHomeCard(
              context: context,
              title: "34".tr,
              icon: ImageAsset.orders,
              onTap: () => Get.toNamed(appRoute.orders),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHomeCard({
    required BuildContext context,
    required String title,
    required String icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 60, height: 60),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

