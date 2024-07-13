import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/features/banner/repo/banner_repo_implementation.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/views/dashboard_view.dart';

import 'core/dashboard_cubit/dashboard_cubit.dart';
import 'core/firebase/custom_firebase.dart';
import 'features/banner/presentation/logic/banners_cubit/banners_cubit.dart';
import 'features/food_menu/presentation/logic/food_menu_cubit/food_menu_cubit.dart';
import 'features/food_menu/repo/food_repo_implementation.dart';

class RestaurantAdminPanelApp extends StatelessWidget {
  const RestaurantAdminPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    CustomFirebase customFirebase = CustomFirebase();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                BannersCubit(BannerRepoImplementation(customFirebase))),
        BlocProvider(
            create: (context) =>
                FoodMenuCubit(FoodRepoImplementation(customFirebase))),
        BlocProvider(
          create: (context) => DashboardCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData.dark(
        ),
        home: const DashboardView(),
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
