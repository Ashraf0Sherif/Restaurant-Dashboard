import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/router/app_router.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/category_food_items_view.dart';

import '../../../banner/presentation/widgets/add_banner_view.dart';
import '../../../orders/presentation/views/orders_view.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is CategoryFoodItems) {
              return CategoryFoodItemsView(
                categoryId: state.categoryId,
              );
            } else if (state is EditBannerView) {
              return AddEditBannerView(
                banner: state.banner,
              );
            } else if (state is DashboardChangeIndex) {
              return AppRouter.views[state.view]!;
            }
            return const OrdersView();
          },
        ),
      ),
    );
  }
}
