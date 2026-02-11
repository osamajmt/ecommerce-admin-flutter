import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String URL;
  final void Function()? onTap;

  const HomeCard({
    super.key,
    required this.title,
    required this.URL,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: colors.surface,
        elevation: 3,
        shadowColor: colors.shadow.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              URL,
              width: 80,
              color: colors.primary,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



