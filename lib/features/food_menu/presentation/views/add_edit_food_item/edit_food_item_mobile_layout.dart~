import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dashboard_cubit/dashboard_cubit.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/spacing.dart';
import '../../../../../core/utils/responsive_views.dart';
import '../../../../dashboard/presentation/widgets/back_ground_container.dart';
import '../../../data/models/food_item/food_item.dart';
import '../../widgets/add_edit_food_item/categories_drop_down_button.dart';
import '../../widgets/add_edit_food_item_bread_crumb.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/add_edit_food_item/extra_ingredients_widget.dart';
import '../../widgets/food_item/add_edit_food_text_field.dart';
import '../../widgets/add_edit_food_item/ingredients_list.dart';

class EditFoodItemMobileLayout extends StatefulWidget {
  final FoodItem item;
  final String categoryId;
  final List<FoodItem> categoryItems;
  final String category;

  const EditFoodItemMobileLayout({
    super.key,
    required this.item,
    required this.categoryId,
    required this.categoryItems,
    required this.category,
  });

  @override
  State<EditFoodItemMobileLayout> createState() => _EditFoodItemMobileState();
}

class _EditFoodItemMobileState extends State<EditFoodItemMobileLayout> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _arabicTitleController;
  late TextEditingController _arabicDescriptionController;
  late TextEditingController _deliveryTimeController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item.title);
    _descriptionController =
        TextEditingController(text: widget.item.description);
    _priceController =
        TextEditingController(text: widget.item.price.toString());
    _arabicTitleController =
        TextEditingController(text: widget.item.arabicTitle);
    _arabicDescriptionController =
        TextEditingController(text: widget.item.arabicDescription);
    _deliveryTimeController =
        TextEditingController(text: widget.item.deliverTime);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _arabicTitleController.dispose();
    _arabicDescriptionController.dispose();
    _deliveryTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BackGroundContainer(
          child: SingleChildScrollView(
        child: Column(
          children: [
            AddEditFoodItemBreadCrumb(
              category: widget.category,
              categoryItems: widget.categoryItems,
              categoryId: widget.categoryId,
              isEdit: true,
            ),
            verticalSpace(10),
            _buildProductDetailsSection(),
            verticalSpace(24),
            _buildArabicDetailsSection(),
            verticalSpace(24),
            _buildExtraDetailsSection(),
            verticalSpace(24),
            _buildActionButtons(),
          ],
        ),
      )),
    );
  }

  Widget _buildProductDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Product Name',
          controller: _titleController,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Description',
          controller: _descriptionController,
          maxLines: 4,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Price',
          controller: _priceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          prefixText: '\$ ',
        ),
        const SizedBox(height: 16),
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        CategoriesDropDownButton(
          categoryId: widget.categoryId,
        ),
        const SizedBox(height: 16),
        const Text(
          'Ingredients',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        IngredientsList(
          ingredients: widget.item.ingredients,
          onAdd: (ingredient) {},
          onRemove: (index) {},
        ),
      ],
    );
  }

  Widget _buildArabicDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Arabic Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        AddEditFoodTextField(
          label: 'Arabic Title',
          controller: _arabicTitleController,
        ),
        const SizedBox(height: 16),
        AddEditFoodTextField(
          label: 'Arabic Description',
          controller: _arabicDescriptionController,
          maxLines: 4,
        ),
        const SizedBox(height: 16),
        AddEditFoodTextField(
          label: 'Delivery Time',
          controller: _deliveryTimeController,
        ),
        const SizedBox(height: 16),
        const Text(
          'Extra Ingredients',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        ExtraIngredientsWidget(
          foodItem: widget.item,
        ),
      ],
    );
  }

  Widget _buildExtraDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Image Upload',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
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
                'Replace Food Item Image',
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
                onPressed: () {},
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

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              context.read<DashboardCubit>().changeView(
                    ResponsiveViews.categoryFoodItems(
                      categoryId: widget.categoryId,
                      foodItems: widget.categoryItems,
                      category: widget.category,
                    ),
                  );
            },
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _updateFoodItem();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsStyles.kPrimaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Update'),
          ),
        ),
      ],
    );
  }

  void _updateFoodItem() {
    log('Updating food item: ${widget.item.title}');
  }
}
