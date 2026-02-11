import 'package:admin_app/constant/appcolor.dart';
import 'package:flutter/material.dart';

class CustomSignAlternative extends StatelessWidget {
  final String action;
  final String state;
  final void Function()? onTap;

  const CustomSignAlternative({
    super.key,
    required this.action,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: state,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
              ),
              TextSpan(
                text: action,
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

