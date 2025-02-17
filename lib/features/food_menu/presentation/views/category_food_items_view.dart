import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/utils/responsive_views.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/food_item_row.dart';

class CategoryFoodItemsView extends StatefulWidget {
  const CategoryFoodItemsView(
      {super.key, required this.foodItems, required this.categoryId});
  final String categoryId;
  final List<FoodItem> foodItems;
  @override
  State<CategoryFoodItemsView> createState() => _CategoryFoodItemsViewState();
}

class _CategoryFoodItemsViewState extends State<CategoryFoodItemsView> {
  void updateStockStatus(int index, bool newValue) {
    widget.foodItems[index].available = newValue;
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      margin: const EdgeInsets.only(top: 10),
      borderRadius: BorderRadius.zero,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                _buildBreadcrumb(),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<DashboardCubit>().changeView(
                          ResponsiveViews.addFoodView(
                              categoryId: widget.categoryId,
                              categoryItems: widget.foodItems),
                        );
                  },
                  icon: const Icon(Icons.add),
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
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: const Row(
                children: [
                  Expanded(flex: 4, child: Text('Product')),
                  Expanded(flex: 2, child: Text('Price')),
                  Expanded(flex: 2, child: Text('Availability')),
                  Expanded(flex: 1, child: Text('Action')),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.foodItems.length,
                itemBuilder: (context, index) => FoodItemRow(
                  item: widget.foodItems[index],
                  index: index,
                  categoryId: widget.categoryId,
                  categoryItems: widget.foodItems,
                  onStockStatusChanged: updateStockStatus,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('Foodie'),
        ),
        const Icon(Icons.chevron_right),
        TextButton(
          onPressed: () => context
              .read<DashboardCubit>()
              .changeView(ResponsiveViews.foodCategories),
          child: const Text('Food Categories'),
        ),
        const Icon(Icons.chevron_right),
        TextButton(
          onPressed: () {},
          child: const Text('Food List'),
        ),
      ],
    );
  }
}
