import 'package:admin_app/constant/appcolor.dart';
import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final String hintText;
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? valid;
  final bool isNumber;
  final bool? isObscure;
  final void Function()? onTapIcon;

  const AuthTextFormField({
    super.key,
    required this.hintText,
    required this.label,
    required this.icon,
    required this.controller,
    this.valid,
    required this.isNumber,
    this.isObscure,
    this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: valid,
      obscureText: isObscure ?? false,
      controller: controller,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 14),
        suffixIcon: InkWell(
          onTap: onTapIcon,
          child: Icon(icon, color: AppColor.primaryColor),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: AppColor.primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}


