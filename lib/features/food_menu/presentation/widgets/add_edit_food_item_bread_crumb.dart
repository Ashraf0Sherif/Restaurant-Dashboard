import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dashboard_cubit/dashboard_cubit.dart';
import '../../../../core/utils/responsive_views.dart';
import '../../data/models/food_item/food_item.dart';

class AddEditFoodItemBreadCrumb extends StatelessWidget {
  const AddEditFoodItemBreadCrumb(
      {super.key,
      this.isEdit = false,
      required this.category,
      required this.categoryItems,
      required this.categoryId});
  final String category;
  final bool isEdit;
  final String categoryId;
  final List<FoodItem> categoryItems;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () => context
              .read<DashboardCubit>()
              .changeView(ResponsiveViews.foodCategories),
          child: const Text('Food Categories'),
        ),
        const Icon(Icons.chevron_right),
        TextButton(
          onPressed: () {
            context
                .read<DashboardCubit>()
                .changeView(ResponsiveViews.categoryFoodItems(
                  categoryId: categoryId,
                  foodItems: categoryItems,
                  category: category,
                ));
          },
          child: Text(category),
        ),
        const Icon(Icons.chevron_right),
        TextButton(
          onPressed: () {},
          child: Text(isEdit ? 'Edit Food Item' : 'Add New Food'),
        ),
      ],
    );
  }
}
