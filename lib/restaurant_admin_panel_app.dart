import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/widgets/category_food_items_view.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/widgets/food_menu_body.dart';

import 'core/dashboard_cubit/dashboard_cubit.dart';

class RestaurantAdminPanelApp extends StatelessWidget {
  const RestaurantAdminPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DashboardCubit(),
        ),
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        home: DashboardView(),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}