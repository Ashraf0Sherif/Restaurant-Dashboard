import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';
import 'package:restaurant_admin_panel/features/food_menu/logic/food_menu_cubit/food_menu_cubit.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/food_category_item.dart';

import '../widgets/add_category_alert_dialog.dart';

class FoodCategoriesView extends StatefulWidget {
  const FoodCategoriesView({super.key});

  @override
  State<FoodCategoriesView> createState() => _FoodCategoriesViewState();
}

class _FoodCategoriesViewState extends State<FoodCategoriesView> {
  List<CategoryModel> categories = [];

  @override
  void initState() {
    BlocProvider.of<FoodMenuCubit>(context).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FoodMenuCubit, FoodMenuState>(
        builder: (context, state) {
          if (state is FoodMenuLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FoodMenuSuccess) {
            categories = state.foodCategories;
            return ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Text(
                      "Food Menu",
                      style: TextStyle(
                        fontSize: FontStyles.getResponsiveFontSize(context, 36),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent.shade200,
                        ),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: ColorsStyles.kCustomRedColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AddCategoryAlertDialog();
                                  });
                            },
                            child: Text("Add New Category",
                                style: TextStyle(
                                  fontSize: FontStyles.getResponsiveFontSize(
                                      context, 16),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )))),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ...List.generate(
                  categories.length >= 5 ? 5 : categories.length,
                  (categoriesIndex) {
                    return FoodCategoryItem(
                        category: categories[categoriesIndex]);
                  },
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
