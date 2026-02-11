import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("100".tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "101".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("102".tr),
            const SizedBox(height: 20),

            ListTile(
              leading: Icon(Icons.email,
                  color: Theme.of(context).colorScheme.primary),
              title: Text("${"103".tr}: support@yourapp.com"),
            ),
            ListTile(
              leading: Icon(Icons.phone,
                  color: Theme.of(context).colorScheme.primary),
              title: Text("${"104".tr}: +963 9XX XXX XXX"),
            ),
          ],
        ),
      ),
    );
  }
}

