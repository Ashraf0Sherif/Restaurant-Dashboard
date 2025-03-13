import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/ingredient/extra_ingredient.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/add_edit_food_item/extra_ingredients_widget.dart';

import '../../../../../core/theming/colors.dart';
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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.cloud_upload,
                size: 50,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'Upload Food Item Image',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Recommended resolution: 640x960',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Implement image upload logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsStyles.kPrimaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Select Image'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
