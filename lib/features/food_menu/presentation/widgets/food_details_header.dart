import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/utils/responsive_views.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';

import '../../../../core/navigation_cubit/navigation_cubit.dart';

class FoodDetailsHeader extends StatelessWidget {
  const FoodDetailsHeader({
    super.key,
    required this.categoryId,
    required this.foodItems, required this.category,
  });
  final String category;
  final String categoryId;
  final List<FoodItem> foodItems;

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Text(
            'Food Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () {
              context.read<NavigationCubit>().changeView(
                  ResponsiveViews.categoryFoodItems(
                      categoryId: categoryId,
                      foodItems: foodItems,
                      category: category,
                    ),
                );
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to List'),
          ),
        ],
      ),
    );
  }
}
