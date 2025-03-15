import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/navigation_cubit.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/core/utils/responsive_views.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';

class CategoryItemsList extends StatelessWidget {
  final List<FoodItem> items;
  final String categoryId;
  final FoodItem currentItem;
  final String category;
  const CategoryItemsList({
    super.key,
    required this.items,
    required this.categoryId,
    required this.currentItem,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final otherItems = items.where((i) => i.id != currentItem.id).toList();

    if (otherItems.isEmpty) return const SizedBox.shrink();

    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'More from this Category',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(16),
          SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: otherItems.length,
              itemBuilder: (context, index) {
                final otherItem = otherItems[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: InkWell(
                    onTap: () {
                      context.read<NavigationCubit>().changeView(
                            ResponsiveViews.foodItemDetails(
                                item: otherItem,
                                categoryId: categoryId,
                                categoryItems: items, category: category),
                          );
                    },
                    child: _buildItemCard(otherItem),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(FoodItem item) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.images[0],
              height: 120,
              width: 180,
              fit: BoxFit.cover,
            ),
          ),
          verticalSpace(8),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          verticalSpace(4),
          Text(
            item.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.available ? Colors.green : Colors.red,
                ),
              ),
              Text(
                item.available ? 'Available' : 'Unavailable',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
