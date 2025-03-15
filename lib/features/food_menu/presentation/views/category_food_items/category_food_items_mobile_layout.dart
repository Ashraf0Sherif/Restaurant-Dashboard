import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dashboard_cubit/navigation_cubit.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/utils/responsive_views.dart';
import '../../../../dashboard/presentation/widgets/back_ground_container.dart';
import '../../../data/models/food_item/food_item.dart';
import '../../widgets/category_food_items_bread_crumb.dart';
import '../../widgets/food_item/food_item_card.dart';

class CategoryFoodItemsMobileLayout extends StatefulWidget {
  const CategoryFoodItemsMobileLayout(
      {super.key, required this.categoryId, required this.foodItems, required this.category});
      final String category;
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
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CategoryFoodItemsBreadCrumb(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<NavigationCubit>().changeView(
                          ResponsiveViews.addFoodView(
                              categoryId: widget.categoryId,
                              categoryItems: widget.foodItems, category: widget.category),
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
              category: widget.category,
            ),
          )
        ],
      ),
    );
  }
}
