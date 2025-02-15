import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';
import 'package:restaurant_admin_panel/features/food_menu/logic/food_menu_cubit/food_menu_cubit.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/category_food_items_grid.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/edit_category_alert_dialog.dart';

class FoodCategoryItem extends StatelessWidget {
  const FoodCategoryItem({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2697FF).withOpacity(0.6),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(26),
                decoration: const BoxDecoration(
                  color: Color(0xFF21222D),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(200),
                    bottomRight: Radius.circular(200),
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    category.imageUrl,
                  ),
                  radius: 120,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF15131C)),
                    child: Text(
                      category.title,
                      style: TextStyle(
                        fontSize: FontStyles.getResponsiveFontSize(context, 34),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  CategoryFoodItemsGrid(category: category),
                ],
              ),
              const Spacer(
                flex: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return EditCategoryAlertDialog(category: category);
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        context
                            .read<FoodMenuCubit>()
                            .deleteCategory(categoryId: category.id);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
              const Spacer()
            ],
          ),
        ),
        verticalSpace(20),
      ],
    );
  }
}
