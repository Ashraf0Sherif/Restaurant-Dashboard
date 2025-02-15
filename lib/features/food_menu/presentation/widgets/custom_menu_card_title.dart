import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';

class CustomMenuCardTitle extends StatelessWidget {
  const CustomMenuCardTitle({
    super.key, required this.title, required this.itemCount,
  });

  final String title;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        horizontalSpace(10),
        Text(
          "$itemCount items",
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
