import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/category_card/category_card.dart';

class CategoriesSliverGrid extends StatelessWidget {
  const CategoriesSliverGrid(
      {super.key, required this.categories, this.isMobile = false});
  final List<CategoryModel> categories;
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: isMobile ? 1 : 1.2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryCard(category: category);
      },
    );
  }
}