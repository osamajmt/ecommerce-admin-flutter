import 'package:flutter/material.dart';

class GlobalTextFormField extends StatelessWidget {
  final String hintText;
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? valid;
  final bool isNumber;
  final bool? isObscure;
  final void Function()? onTapIcon;

  const GlobalTextFormField({
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
    final colors = Theme.of(context).colorScheme;

    return TextFormField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: valid,
      obscureText: isObscure ?? false,
      controller: controller,
      style: TextStyle(
        fontSize: 16,
        color: colors.onSurface,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.surface,
        hintText: hintText,
        hintStyle: TextStyle(
          color: colors.onSurface.withOpacity(0.5),
          fontSize: 14,
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: colors.onSurface.withOpacity(0.7),
          fontSize: 14,
        ),
        suffixIcon: InkWell(
          onTap: onTapIcon,
          child: Icon(icon, color: colors.primary),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: colors.outline.withOpacity(0.6),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: colors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}




