import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/utils/responsive_views.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';

import '../../../../../core/navigation_cubit/navigation_cubit.dart';
import 'category_card_body.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 56, 56, 56),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.read<NavigationCubit>().changeView(
                ResponsiveViews.categoryFoodItems(
                  categoryId: category.id,
                  foodItems: category.foodItems, category: category.title,
                ),
              );
        },
        child: CategoryCardBody(category: category),
      ),
    );
  }
}
