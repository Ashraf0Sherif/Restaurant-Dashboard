import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/ingredient/extra_ingredient.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/extra_ingredients_widget.dart';

import '../food_item/add_edit_food_text_field.dart';

class RightSideSection extends StatefulWidget {
  const RightSideSection({super.key, required this.categoryId, this.item});
  final String categoryId;
  final FoodItem? item;
  @override
  State<RightSideSection> createState() => _RightSideSectionState();
}

class _RightSideSectionState extends State<RightSideSection> {
  final List<ExtraIngredient> _extraIngredients = [];

  late final TextEditingController _arabicTitleController,
      _arabicDescriptionController,
      _deliverTimeController;

  @override
  void initState() {
    super.initState();
    _arabicTitleController =
        TextEditingController(text: widget.item?.arabicTitle);
    _arabicDescriptionController =
        TextEditingController(text: widget.item?.arabicDescription);
    _deliverTimeController =
        TextEditingController(text: widget.item?.deliverTime);
    _extraIngredients.addAll(widget.item?.extraIngredients ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddEditFoodTextField(
          label: 'Arabic Title',
          controller: _arabicTitleController,
        ),
        verticalSpace(16),
        AddEditFoodTextField(
          label: 'Arabic Description',
          controller: _arabicDescriptionController,
          maxLines: 4,
        ),
        verticalSpace(16),
        AddEditFoodTextField(
          label: 'Delivery Time',
          controller: _deliverTimeController,
        ),
        verticalSpace(24),
        const Text(
          'Extra Ingredients',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        verticalSpace(8),
        ExtraIngredientsWidget(
          foodItem: widget.item,
        ),
        verticalSpace(16),
        const Text(
          'Please upload any file to see a preview',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        verticalSpace(8),
        const Text(
          '* Recommended resolution is 640*960 with file size',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
