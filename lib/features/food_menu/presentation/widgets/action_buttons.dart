import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/core/utils/responsive_views.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/category_food_items_view.dart';

class ActionButtons extends StatelessWidget {
  final String categoryId;
  final List<FoodItem> categoryItems;
  final VoidCallback? onSave;

  const ActionButtons({
    super.key,
    required this.categoryId,
    required this.categoryItems,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            context.read<DashboardCubit>().changeView(
                  ResponsiveViews.categoryFoodItems(
                      categoryId: categoryId, foodItems: categoryItems),
                );
          },
          child: const Text('Cancel'),
        ),
        horizontalSpace(16),
        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsStyles.kPrimaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
