import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/core/utils/responsive_views.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';

import '../widgets/food_details/action_buttons.dart';
import '../widgets/sections/left_side_section.dart';
import '../widgets/sections/right_side_section.dart';

class EditFoodView extends StatelessWidget {
  final FoodItem item;
  final String categoryId;
  final List<FoodItem> categoryItems;

  const EditFoodView({
    super.key,
    required this.item,
    required this.categoryId,
    required this.categoryItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Text(
                'Edit Food',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  context.read<DashboardCubit>().changeView(
                        ResponsiveViews.categoryFoodItems(
                            categoryId: categoryId, foodItems: categoryItems),
                      );
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to List'),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: BackGroundContainer(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: LeftSideSection(
                            categoryId: categoryId,
                            item: item,
                          ),
                        ),
                        horizontalSpace(24),
                        Expanded(
                            child: RightSideSection(
                          categoryId: categoryId,
                          item: item,
                        )),
                      ],
                    ),
                    verticalSpace(24),
                    ActionButtons(
                      categoryId: categoryId,
                      categoryItems: categoryItems,
                      onSave: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
