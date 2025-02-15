import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/food_categories_view.dart';

class CategoryFoodItemsView extends StatefulWidget {
  const CategoryFoodItemsView(
      {super.key, required this.foodItems, required this.categoryId});
  final String categoryId;
  final List<FoodItem> foodItems;
  @override
  State<CategoryFoodItemsView> createState() => _CategoryFoodItemsViewState();
}

class _CategoryFoodItemsViewState extends State<CategoryFoodItemsView> {
  late final List<FoodItem> foodItems;

  void updateStockStatus(int index, bool? newValue) {
    if (newValue != null) {
      setState(() {
        foodItems[index].available = newValue;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    foodItems = widget.foodItems;
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
                  onPressed: () {},
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
                  Expanded(flex: 2, child: Text('Stock Status')),
                  Expanded(flex: 1, child: Text('Action')),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: foodItems.length,
                itemBuilder: (context, index) => _buildFoodItem(index),
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
          onPressed: () => context.read<DashboardCubit>().changeView(
              const ResponsiveWidget(
                  mobile: FoodCategoriesView(), tablet: FoodCategoriesView())),
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

  Widget _buildFoodItem(int index) {
    final item = foodItems[index];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(item.images[0]),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Text(item.title),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text('\$${item.price}')),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<bool>(
                  value: item.available,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (bool? newValue) =>
                      updateStockStatus(index, newValue),
                  items: [
                    DropdownMenuItem(
                      value: true,
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                          const Text('Available'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                          const Text('Unavailable'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.visibility_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
