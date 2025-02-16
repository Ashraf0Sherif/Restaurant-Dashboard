import 'package:flutter/material.dart';

class FoodItemActions extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onView;

  const FoodItemActions({
    super.key,
    this.onEdit,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: onEdit,
        ),
        IconButton(
          icon: const Icon(Icons.visibility_outlined),
          onPressed: onView,
        ),
      ],
    );
  }
}
