import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/utils/responsive_views.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/food_item_actions.dart';

class FoodItemRow extends StatefulWidget {
  final FoodItem item;
  final int index;
  final String categoryId;
  final List<FoodItem> categoryItems;
  final Function(int, bool) onStockStatusChanged;

  const FoodItemRow({
    super.key,
    required this.item,
    required this.index,
    required this.categoryId,
    required this.categoryItems,
    required this.onStockStatusChanged,
  });

  @override
  State<FoodItemRow> createState() => _FoodItemRowState();
}

class _FoodItemRowState extends State<FoodItemRow> {
  void _updateAvailability(bool? newValue) {
    if (newValue != null) {
      setState(
        () {
          widget.item.available = newValue;
        },
      );
      widget.onStockStatusChanged(widget.index, newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: NetworkImage(widget.item.images[0]),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Text(widget.item.title),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text('\$${widget.item.price}')),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<bool>(
                  value: widget.item.available,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: _updateAvailability,
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
            child: FoodItemActions(
              onEdit: () {
                context.read<DashboardCubit>().changeView(
                      ResponsiveViews.editFoodView(
                        item: widget.item,
                        categoryId: widget.categoryId,
                        categoryItems: widget.categoryItems,
                      ),
                    );
              },
              onView: () {
                context.read<DashboardCubit>().changeView(
                      ResponsiveViews.foodItemDetails(
                        item: widget.item,
                        categoryId: widget.categoryId,
                        categoryItems: widget.categoryItems,
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
