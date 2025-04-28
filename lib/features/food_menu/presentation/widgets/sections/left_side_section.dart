import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/ingredient/ingredient.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/add_edit_food_item/categories_drop_down_button.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/custom_text_field.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/add_edit_food_item/ingredients_list.dart';

class LeftSideSection extends StatefulWidget {
  const LeftSideSection(
      {super.key, required this.categoryId,this.item});
  final String categoryId;
  final FoodItem? item;
  @override
  State<LeftSideSection> createState() => _LeftSideSectionState();
}

class _LeftSideSectionState extends State<LeftSideSection> {
  late final TextEditingController _titleController,
      _descriptionController,
      _priceController;
  late final List<Ingredient> _ingredients;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item?.title);
    _descriptionController =
        TextEditingController(text: widget.item?.description);
    _priceController =
        TextEditingController(text: widget.item?.price.toString());
    _ingredients = List.from(widget.item?.mainIngredients ?? []);
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: 'Product Name',
          controller: _titleController,
        ),
        verticalSpace(16),
        CustomTextField(
          label: 'Description',
          controller: _descriptionController,
          maxLines: 4,
        ),
        verticalSpace(16),
        CustomTextField(
          label: 'Price',
          controller: _priceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          prefixText: '\$ ',
        ),
        verticalSpace(16),
        IngredientsList(
          ingredients: _ingredients,
          onAdd: (ingredient) {
            setState(() {
              _ingredients.add(ingredient);
            });
          },
          onRemove: _removeIngredient,
        ),
        verticalSpace(16),
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        verticalSpace(16),
        CategoriesDropDownButton(
          categoryId: widget.categoryId,
        ),
      ],
    );
  }
}
