import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/ingredient/extra_ingredient.dart';

class ExtraIngredientsList extends StatefulWidget {
  final List<ExtraIngredient> extraIngredients;
  final Function(ExtraIngredient) onAdd;
  final Function(int) onRemove;

  const ExtraIngredientsList({
    super.key,
    required this.extraIngredients,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<ExtraIngredientsList> createState() => _ExtraIngredientsListState();
}

class _ExtraIngredientsListState extends State<ExtraIngredientsList> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _arabicNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _arabicNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _addExtraIngredient() {
    if (_nameController.text.isNotEmpty &&
        _arabicNameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      widget.onAdd(ExtraIngredient(
        title: _nameController.text,
        arabicTitle: _arabicNameController.text,
        price: _priceController.text,
      ));
      _nameController.clear();
      _arabicNameController.clear();
      _priceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Extra Ingredients',
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
                          hintText: 'Extra ingredient name',
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
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                          hintText: 'Price',
                          isDense: true,
                          border: OutlineInputBorder(),
                          prefixText: '\$ ',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
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
              if (widget.extraIngredients.isEmpty)
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
                  itemCount: widget.extraIngredients.length,
                  separatorBuilder: (context, index) => verticalSpace(8),
                  itemBuilder: (context, index) {
                    final ingredient = widget.extraIngredients[index];
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
