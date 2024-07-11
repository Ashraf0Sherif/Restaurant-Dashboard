import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/router/app_router.dart';
import 'package:restaurant_admin_panel/features/banner/presentation/views/banners_view.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/food_menu.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/widgets/category_food_items_view.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/widgets/food_categories_view.dart';

import '../../../../orders/presentation/views/orders_view.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is CategoryFoodItems) {
              return CategoryFoodItemsView(
                foodItems: state.foodItems,
                categoryId: state.categoryId,
              );
            }
            if (state is DashboardChangeIndex) {
              return AppRouter.views[state.view]!;
            }
            return const OrdersView();
          },
        ),
      ),
    );
  }
}
