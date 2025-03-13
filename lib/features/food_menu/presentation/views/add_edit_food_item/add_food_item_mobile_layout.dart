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

class AddFoodItemMobileLayout extends StatefulWidget {
  final String category;
  final String categoryId;
  final List<FoodItem> categoryItems;
  final FoodItem? existingItem;

  const AddFoodItemMobileLayout({
    super.key,
    required this.categoryId,
    required this.categoryItems,
    this.existingItem,
    required this.category,
  });

  @override
  State<AddFoodItemMobileLayout> createState() => _AddFoodViewMobileState();
}

class _AddFoodViewMobileState extends State<AddFoodItemMobileLayout> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BackGroundContainer(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: verticalSpace(10),
            ),
            SliverToBoxAdapter(
              child: AddEditFoodItemBreadCrumb(
                category: widget.category,
                categoryItems: widget.categoryItems,
                categoryId: widget.categoryId,
              ),
            ),
            SliverToBoxAdapter(
              child: verticalSpace(10),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildProductDetailsSection(),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildArabicDetailsSection(),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildExtraDetailsSection(),
                  const SizedBox(height: 24),
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
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
          controller: TextEditingController(
            text: widget.existingItem?.title,
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Description',
          controller: TextEditingController(
            text: widget.existingItem?.description,
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Price',
          controller: TextEditingController(
            text: widget.existingItem?.price.toString(),
          ),
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
        IngredientsList(
          ingredients: widget.existingItem?.ingredients ?? [],
          onAdd: (ingredient) {
            // Implement add ingredient logic
          },
          onRemove: (index) {
            // Implement remove ingredient logic
          },
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
          controller: TextEditingController(
            text: widget.existingItem?.arabicTitle,
          ),
        ),
        const SizedBox(height: 16),
        AddEditFoodTextField(
          label: 'Arabic Description',
          controller: TextEditingController(
            text: widget.existingItem?.arabicDescription,
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 16),
        AddEditFoodTextField(
          label: 'Delivery Time',
          controller: TextEditingController(
            text: widget.existingItem?.deliverTime,
          ),
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
          foodItem: widget.existingItem,
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
              // Implement add/edit food item logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsStyles.kPrimaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text(widget.existingItem != null ? 'Update' : 'Add Food'),
          ),
        ),
      ],
    );
  }
}
