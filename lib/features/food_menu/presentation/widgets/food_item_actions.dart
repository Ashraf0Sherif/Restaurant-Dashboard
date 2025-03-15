import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dashboard_cubit/navigation_cubit.dart';
import '../../../../core/utils/responsive_views.dart';
import '../../data/models/food_item/food_item.dart';

class FoodItemActions extends StatelessWidget {
  const FoodItemActions({
    super.key,
    required this.item,
    required this.categoryId,
    required this.categoryItems,
    required this.category,
  });
  final String category;
  final FoodItem item;
  final String categoryId;
  final List<FoodItem> categoryItems;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {
            context.read<NavigationCubit>().changeView(
                  ResponsiveViews.editFoodView(
                    item: item,
                    categoryId: categoryId,
                    categoryItems: categoryItems, category: category,
                  ),
                );
          },
          color: Colors.orange,
        ),
        IconButton(
          icon: const Icon(Icons.visibility_outlined),
          onPressed: () {
            context.read<NavigationCubit>().changeView(
                  ResponsiveViews.foodItemDetails(
                    item: item,
                    categoryId: categoryId,
                    categoryItems: categoryItems,
                    category: category,
                  ),
                );
          },
          color: Colors.blue,
        ),
      ],
    );
  }
}
