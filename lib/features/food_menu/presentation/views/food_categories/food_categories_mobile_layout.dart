import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';
import 'package:restaurant_admin_panel/features/food_menu/logic/food_menu_cubit/food_menu_cubit.dart';
import '../../widgets/food_categories/food_categories_mobile_layout_body.dart';
class FoodCategoriesMobileLayout extends StatefulWidget {
  const FoodCategoriesMobileLayout({super.key});

  @override
  State<FoodCategoriesMobileLayout> createState() =>
      _FoodCategoriesMobileLayoutState();
}

class _FoodCategoriesMobileLayoutState
    extends State<FoodCategoriesMobileLayout> {
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
            return FoodCategoriesMobileLayoutBody(
              categories: categories,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
