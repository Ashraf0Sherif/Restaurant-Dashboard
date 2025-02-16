import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/category_items_list.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/food_details_header.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/food_details_mobile_layout_body.dart';

class FoodItemDetailsMobileLayout extends StatelessWidget {
  const FoodItemDetailsMobileLayout({
    super.key,
    required this.item,
    required this.categoryId,
    required this.categoryItems,
  });

  final FoodItem item;
  final String categoryId;
  final List<FoodItem> categoryItems;

  @override
  Widget build(BuildContext context) {
    final otherItems = categoryItems.where((i) => i.id != item.id).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FoodDetailsHeader(categoryId: categoryId, otherItems: otherItems),
            verticalSpace(10),
            FoodItemDetailsMobilelLayoutBody(item: item),
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
    );
  }
}


