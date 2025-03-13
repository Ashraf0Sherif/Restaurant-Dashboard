import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/food_item_actions.dart';

import '../../../data/models/food_item/food_item.dart';


class FoodItemCard extends StatefulWidget {
  const FoodItemCard({
    super.key,
    required this.item,
    required this.index,
    required this.categoryId,
    required this.categoryItems,
    required this.onStockStatusChanged, required this.category,
  });

  final FoodItem item;
  final int index;
  final String categoryId;
  final String category;
  final List<FoodItem> categoryItems;
  final Function(int, bool) onStockStatusChanged;

  @override
  State<FoodItemCard> createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  void _updateAvailability(bool? newValue) {
    if (newValue != null) {
      setState(() {
        widget.item.available = newValue;
      });
      widget.onStockStatusChanged(widget.index, newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      color: const Color.fromARGB(255, 56, 56, 56),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.item.images[0],
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${widget.item.price}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<bool>(
                        value: widget.item.available,
                        isExpanded: true,
                        isDense: true,
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
                                const Text('Available',
                                    style: TextStyle(fontSize: 14)),
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
                                const Text('Unavailable',
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FoodItemActions(
                    item: widget.item,
                    categoryId: widget.categoryId,
                    categoryItems: widget.categoryItems, category: widget.category,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
