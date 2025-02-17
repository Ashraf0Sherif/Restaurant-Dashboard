import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/core/utils/responsive_views.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';

class CategoryFoodItemsGrid extends StatelessWidget {
  final CategoryModel category;

  const CategoryFoodItemsGrid({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      height: 180,
      child: GridView.builder(
        itemCount: category.foodItems.length + 1,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 2,
          childAspectRatio: 6,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == category.foodItems.length || index == 5) {
            return InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                context.read<DashboardCubit>().changeView(
                      ResponsiveViews.categoryFoodItems(
                        categoryId: category.id,
                        foodItems: category.foodItems,
                      ),
                    );
              },
              child: Row(
                children: [
                  Text(
                    "Show Items",
                    style: TextStyle(
                      fontSize: FontStyles.getResponsiveFontSize(context, 18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.arrow_forward)
                ],
              ),
            );
          } else {
            return Row(
              children: [
                Text(
                  category.foodItems[index].title,
                  style: TextStyle(
                    fontSize: FontStyles.getResponsiveFontSize(context, 24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                horizontalSpace(40),
                Text(
                  "\$${category.foodItems[index].price}",
                  style: TextStyle(
                    fontSize: FontStyles.getResponsiveFontSize(context, 24),
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
