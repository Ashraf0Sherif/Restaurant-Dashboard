import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';

class FoodItemDetailsMobilelLayoutBody extends StatelessWidget {
  const FoodItemDetailsMobilelLayoutBody({super.key, required this.item});
  final FoodItem item;
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.images[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          verticalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item.title} - ${item.arabicTitle}",
                style: const TextStyle(
                  color: ColorsStyles.kPrimaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Description : ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Arabic Description : ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    item.arabicDescription,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              verticalSpace(10),
              Text(
                'Status : ${item.available ? 'Available' : 'Unavailable'}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              verticalSpace(10),
              const Text(
                'Main Ingredients:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpace(10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: item.mainIngredients
                    .map((ingredient) => Chip(
                          label: Text(ingredient.title),
                          backgroundColor: Colors.grey[800],
                        ))
                    .toList(),
              ),
              verticalSpace(10),
              const Text(
                'Extra Ingredients:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpace(10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: item.extraIngredients
                    .map((extraIngredient) => Chip(
                          label: Text(extraIngredient.title),
                          backgroundColor: Colors.grey[800],
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price :',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '\$ ${item.price}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
