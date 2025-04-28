import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';
import 'package:restaurant_admin_panel/features/food_menu/logic/food_menu_cubit/food_menu_cubit.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/food_categories/food_categories_tablet_layout_body.dart';

import '../../../../../core/helpers/assets.dart';

class FoodCategoriesTabletLayout extends StatefulWidget {
  const FoodCategoriesTabletLayout({super.key});

  @override
  State<FoodCategoriesTabletLayout> createState() =>
      _FoodCategoriesTabletLayoutState();
}

class _FoodCategoriesTabletLayoutState
    extends State<FoodCategoriesTabletLayout> {
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
            return  Center(
              child: Lottie.asset(AssetsData.kLoadingLottieAnimation,
                  animate: true, width: 100),
            );
          } else if (state is FoodMenuSuccess) {
            categories = state.foodCategories;
            return FoodCategoriesTabletLayoutBody(
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
