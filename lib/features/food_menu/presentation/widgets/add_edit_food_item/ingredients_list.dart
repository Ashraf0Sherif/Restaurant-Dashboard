import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/ingredient/ingredient.dart';

class IngredientsList extends StatefulWidget {
  final List<Ingredient> ingredients;
  final Function(Ingredient) onAdd;
  final Function(int) onRemove;

  const IngredientsList({
    super.key,
    required this.ingredients,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<IngredientsList> createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _arabicNameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _arabicNameController.dispose();
    super.dispose();
  }

  void _addIngredient() {
    if (_nameController.text.isNotEmpty && _arabicNameController.text.isNotEmpty) {
      widget.onAdd(Ingredient(
        title: _nameController.text,
        arabicTitle: _arabicNameController.text,
      ));
      _nameController.clear();
      _arabicNameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredients',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        verticalSpace(8),
        Container(
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
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Ingredient name',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    horizontalSpace(8),
                    Expanded(
                      child: TextField(
                        controller: _arabicNameController,
                        decoration: const InputDecoration(
                          hintText: 'Arabic name',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    horizontalSpace(8),
                    ElevatedButton(
                      onPressed: _addIngredient,
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
              if (widget.ingredients.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'No ingredients added yet',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(12),
                  itemCount: widget.ingredients.length,
                  separatorBuilder: (context, index) => verticalSpace(8),
                  itemBuilder: (context, index) {
                    final ingredient = widget.ingredients[index];
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
                        IconButton(
                          onPressed: () => widget.onRemove(index),
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
