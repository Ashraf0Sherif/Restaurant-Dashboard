import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/category_food_items_view.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/category_items_list.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/food_details_section.dart';

class FoodItemDetailsView extends StatelessWidget {
  final FoodItem item;
  final String categoryId;
  final List<FoodItem> categoryItems;

  const FoodItemDetailsView({
    super.key,
    required this.item,
    required this.categoryId,
    required this.categoryItems,
  });

  @override
  Widget build(BuildContext context) {
    final otherItems = categoryItems.where((i) => i.id != item.id).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Text(
                'Food Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  context.read<DashboardCubit>().changeView(
                        ResponsiveWidget(
                          mobile: CategoryFoodItemsView(
                            categoryId: categoryId,
                            foodItems: categoryItems,
                          ),
                          tablet: CategoryFoodItemsView(
                            categoryId: categoryId,
                            foodItems: categoryItems,
                          ),
                        ),
                      );
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to List'),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                BackGroundContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.images[0],
                                height: 300,
                                width: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        horizontalSpace(24),
                        Expanded(
                          child: FoodDetailsSection(item: item),
                        ),
                      ],
                    ),
                  ),
                ),
                if (otherItems.isNotEmpty) ...[
                  verticalSpace(24),
                  CategoryItemsList(
                    items: categoryItems,
                    categoryId: categoryId,
                    currentItem: item,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
