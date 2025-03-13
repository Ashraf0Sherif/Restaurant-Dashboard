import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dashboard_cubit/dashboard_cubit.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/utils/responsive_views.dart';
import '../../../../dashboard/presentation/widgets/back_ground_container.dart';
import '../../../data/models/food_item/food_item.dart';
import '../../widgets/food_item/food_item_card.dart';

class CategoryFoodItemsMobileLayout extends StatefulWidget {
  const CategoryFoodItemsMobileLayout(
      {super.key, required this.categoryId, required this.foodItems});
  final String categoryId;
  final List<FoodItem> foodItems;
  @override
  State<CategoryFoodItemsMobileLayout> createState() =>
      _CategoryFoodItemsMobileLayoutState();
}

class _CategoryFoodItemsMobileLayoutState
    extends State<CategoryFoodItemsMobileLayout> {
  void updateStockStatus(int index, bool newValue) {
    setState(() {
      widget.foodItems[index].available = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      borderRadius: BorderRadius.zero,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildBreadcrumb(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<DashboardCubit>().changeView(
                          ResponsiveViews.addFoodView(
                              categoryId: widget.categoryId,
                              categoryItems: widget.foodItems),
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
                        horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),
          SliverList.builder(
            itemCount: widget.foodItems.length,
            itemBuilder: (context, index) => FoodItemCard(
              item: widget.foodItems[index],
              index: index,
              categoryId: widget.categoryId,
              categoryItems: widget.foodItems,
              onStockStatusChanged: updateStockStatus,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('Foodie'),
          ),
          const Icon(Icons.chevron_right, size: 16),
          TextButton(
            onPressed: () => context
                .read<DashboardCubit>()
                .changeView(ResponsiveViews.foodCategories),
            child: const Text('Food Categories'),
          ),
          const Icon(Icons.chevron_right, size: 16),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: const Text('Food List'),
          ),
        ],
      ),
    );
  }
}
