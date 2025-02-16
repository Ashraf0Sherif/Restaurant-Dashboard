import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/ingredient/extra_ingredient.dart';

class ExtraIngredientsWidget extends StatefulWidget {
  const ExtraIngredientsWidget({super.key, this.foodItem});
  final FoodItem? foodItem;
  @override
  State<ExtraIngredientsWidget> createState() => _ExtraIngredientsWidgetState();
}

class _ExtraIngredientsWidgetState extends State<ExtraIngredientsWidget> {
  final TextEditingController _newExtraIngredientController =
      TextEditingController();
  final TextEditingController _newExtraIngredientArabicController =
      TextEditingController();
  final TextEditingController _newExtraIngredientPriceController =
      TextEditingController();
  final List<ExtraIngredient> _extraIngredients = [];

  void _addExtraIngredient() {
    if (_newExtraIngredientController.text.isNotEmpty &&
        _newExtraIngredientArabicController.text.isNotEmpty &&
        _newExtraIngredientPriceController.text.isNotEmpty) {
      setState(() {
        _extraIngredients.add(ExtraIngredient(
          title: _newExtraIngredientController.text,
          arabicTitle: _newExtraIngredientArabicController.text,
          price: _newExtraIngredientPriceController.text,
        ));
        _newExtraIngredientController.clear();
        _newExtraIngredientArabicController.clear();
        _newExtraIngredientPriceController.clear();
      });
    }
  }

  void _removeExtraIngredient(int index) {
    setState(() {
      _extraIngredients.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _extraIngredients.addAll(widget.foodItem?.extraIngredients ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newExtraIngredientController,
                    decoration: const InputDecoration(
                      hintText: 'Extra ingredient name',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                horizontalSpace(8),
                Expanded(
                  child: TextField(
                    controller: _newExtraIngredientArabicController,
                    decoration: const InputDecoration(
                      hintText: 'Arabic name',
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                horizontalSpace(8),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _newExtraIngredientPriceController,
                    decoration: const InputDecoration(
                      hintText: 'Price',
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixText: '\$ ',
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                horizontalSpace(8),
                ElevatedButton(
                  onPressed: _addExtraIngredient,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsStyles.kPrimaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (_extraIngredients.isEmpty)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'No extra ingredients added yet',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              itemCount: _extraIngredients.length,
              separatorBuilder: (context, index) => verticalSpace(8),
              itemBuilder: (context, index) {
                final ingredient = _extraIngredients[index];
                return Row(
                  children: [
                    Expanded(
                      child: Text(ingredient.title),
                    ),
                    horizontalSpace(8),
                    Expanded(
                      child: Text(ingredient.arabicTitle),
                    ),
                    horizontalSpace(8),
                    SizedBox(
                      width: 100,
                      child: Text('\$ ${ingredient.price}'),
                    ),
                    horizontalSpace(8),
                    IconButton(
                      onPressed: () => _removeExtraIngredient(index),
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
