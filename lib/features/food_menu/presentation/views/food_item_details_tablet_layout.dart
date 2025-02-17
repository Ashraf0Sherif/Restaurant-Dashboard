import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/category_items_list.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/food_details_header.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/food_details_tablet_layout_body.dart';

class FoodItemDetailsTabletLayout extends StatelessWidget {
  final FoodItem item;
  final String categoryId;
  final List<FoodItem> categoryItems;

  const FoodItemDetailsTabletLayout({
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
        verticalSpace(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              FoodDetailsHeader(categoryId: categoryId, otherItems: otherItems),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                BackGroundContainer(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item.images[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(24),
                      Expanded(
                        flex: 2,
                        child: FoodDetailsTabletLayoutBody(item: item),
                      ),
                    ],
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
