import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/core/utils/responsive_views.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/add_edit_food_item_bread_crumb.dart';

import '../../../../../core/navigation_cubit/navigation_cubit.dart';
import '../../widgets/sections/left_side_section.dart';
import '../../widgets/sections/right_side_section.dart';

class EditFoodItemTabletLayout extends StatefulWidget {
  final FoodItem item;
  final String categoryId;
  final List<FoodItem> categoryItems;
  final String category;
  const EditFoodItemTabletLayout({
    super.key,
    required this.item,
    required this.categoryId,
    required this.categoryItems,
    required this.category,
  });

  @override
  State<EditFoodItemTabletLayout> createState() =>
      _EditFoodItemTabletLayoutState();
}

class _EditFoodItemTabletLayoutState extends State<EditFoodItemTabletLayout> {
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
                categoryId: widget.categoryId,isEdit: true,),
            verticalSpace(10),
            _buildTwoColumnLayout(),
            verticalSpace(24),
            _buildActionButtons(),
          ],
        ),
      )),
    );
  }

  Widget _buildTwoColumnLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildLeftSection(),
        ),
        horizontalSpace(24),
        Expanded(
          child: _buildRightSection(),
        ),
      ],
    );
  }

  Widget _buildLeftSection() {
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
        verticalSpace(16),
        LeftSideSection(
          categoryId: widget.categoryId,
          item: widget.item,
        ),
      ],
    );
  }

  Widget _buildRightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpace(16),
        RightSideSection(
          categoryId: widget.categoryId,
          item: widget.item,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
            context.read<NavigationCubit>().changeView(
                  ResponsiveViews.categoryFoodItems(
                    categoryId: widget.categoryId,
                    foodItems: widget.categoryItems,
                    category: widget.category,
                  ),
                );
          },
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsStyles.kPrimaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Update'),
        ),
      ],
    );
  }
}
