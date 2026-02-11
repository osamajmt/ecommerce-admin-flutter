import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SystemInfo extends StatelessWidget {
  const SystemInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("105".tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "106".tr,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),

            _infoRow(context, "107".tr, "1.0.0"),
            _infoRow(context, "108".tr, "Production"),

            const Divider(height: 30),

            _infoRow(context, "109".tr, "Osama Aljomaat"),
            _infoRow(context, "110".tr, "support@yourapp.com"),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}




