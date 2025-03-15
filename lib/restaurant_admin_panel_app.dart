import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/theming/foodie_theme.dart';
import 'package:restaurant_admin_panel/landing_view.dart';
import 'package:restaurant_admin_panel/features/banner/data/repos/banner_repo_implementation.dart';
import 'core/navigation_cubit/navigation_cubit.dart';
import 'core/services/firebase/restaurant_firebase.dart';
import 'features/banner/logic/banners_cubit/banners_cubit.dart';
import 'features/food_menu/logic/food_menu_cubit/food_menu_cubit.dart';
import 'features/food_menu/data/repos/food_repo_implementation.dart';

class RestaurantAdminPanelApp extends StatelessWidget {
  const RestaurantAdminPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    RestaurantFirebase customFirebase = RestaurantFirebase();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                BannersCubit(BannerRepoImplementation(customFirebase))),
        BlocProvider(
            create: (context) =>
                FoodMenuCubit(FoodRepoImplementation(customFirebase))),
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
      ],
      child: MaterialApp(
        //locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        theme: foodieTheme(context),
        home: const SafeArea(child: LandingView()),
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
