import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';

class FoodDetailsTabletLayoutBody extends StatelessWidget {
  const FoodDetailsTabletLayoutBody({super.key, required this.item});

  final FoodItem item;

  Padding _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          horizontalSpace(8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Title', item.title),
        _buildDetailRow('Arabic Title', item.arabicTitle),
        _buildDetailRow('Description', item.description),
        _buildDetailRow('Arabic Description', item.arabicDescription),
        _buildDetailRow('Price', '\$${item.price}'),
        _buildDetailRow('Delivery Time', item.deliverTime),
        _buildDetailRow('Status', item.available ? 'Available' : 'Unavailable'),
        verticalSpace(16),
        const Text(
          'Main Ingredients:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpace(8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: item.ingredients
              .map((ingredient) => Chip(
                    label: Text(ingredient.title),
                    backgroundColor: Colors.grey[800],
                  ))
              .toList(),
        ),
        verticalSpace(16),
        if (item.extraIngredients.isNotEmpty) ...[
          const Text(
            'Extra Ingredients:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: item.extraIngredients
                .map((ingredient) => Chip(
                      label:
                          Text('${ingredient.title} (\$${ingredient.price})'),
                      backgroundColor: Colors.grey[800],
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }
}
