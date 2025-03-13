import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/categories_view_body.dart';

import '../../../../../core/theming/spacing.dart';

class FoodCategoriesTabletLayoutBody extends StatelessWidget {
  const FoodCategoriesTabletLayoutBody({super.key, required this.categories});
  final List<CategoryModel> categories;
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      margin: const EdgeInsets.only(left: 10),
      borderRadius: BorderRadius.circular(8),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: verticalSpace(10),
          ),
          CategoriesSliverGrid(
            categories: categories,
          ),
        ],
      ),
    );
  }
}
