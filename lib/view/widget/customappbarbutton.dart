import 'package:flutter/material.dart';

class CustomAppBarButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final bool isActive;

  const CustomAppBarButton({
    super.key,
    required this.icon,
    this.onPressed,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
        decoration: BoxDecoration(
          color:
              isActive ? colors.primary.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          icon,
          size: 30,
          color: isActive ? colors.primary : colors.onSurface.withOpacity(0.6),
        ),
      ),
    );
  }
}



