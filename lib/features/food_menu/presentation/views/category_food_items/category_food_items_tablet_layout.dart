import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/utils/responsive_views.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/category_food_items_bread_crumb.dart';

import '../../../../../core/navigation_cubit/navigation_cubit.dart';
import '../../widgets/food_item/food_item_row.dart';

class CategoryFoodItemsTabletLayout extends StatefulWidget {
  const CategoryFoodItemsTabletLayout(
      {super.key,
      required this.foodItems,
      required this.categoryId,
      required this.category});
  final String categoryId;
  final String category;
  final List<FoodItem> foodItems;
  @override
  State<CategoryFoodItemsTabletLayout> createState() =>
      _CategoryFoodItemsTabletLayoutState();
}

class _CategoryFoodItemsTabletLayoutState
    extends State<CategoryFoodItemsTabletLayout> {
  void updateStockStatus(int index, bool newValue) {
    widget.foodItems[index].available = newValue;
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      margin: const EdgeInsets.only(left: 10),
      borderRadius: BorderRadius.zero,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              children: [
                const CategoryFoodItemsBreadCrumb(),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<NavigationCubit>().changeView(
                          ResponsiveViews.addFoodView(
                              categoryId: widget.categoryId,
                              categoryItems: widget.foodItems,
                              category: widget.category),
                        );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: const Text('Add New Food'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsStyles.kPrimaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: const Row(
                children: [
                  Expanded(flex: 5, child: Text('Product')),
                  Expanded(flex: 3, child: Text('Price')),
                  Expanded(flex: 3, child: Text('Availability')),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Text('Action'),
                      )),
                ],
              ),
            ),
          ),
          SliverList.builder(
            itemCount: widget.foodItems.length,
            itemBuilder: (context, index) => FoodItemRow(
              item: widget.foodItems[index],
              index: index,
              categoryId: widget.categoryId,
              categoryItems: widget.foodItems,
              onStockStatusChanged: updateStockStatus,
              category: widget.category,
            ),
          )
        ],
      ),
    );
  }

}
