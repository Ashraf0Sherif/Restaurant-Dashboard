import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/landing_view.dart';
import 'package:restaurant_admin_panel/features/orders/presentation/views/orders_view.dart';

import '../../features/banner/presentation/views/banners_view.dart';
import '../../features/banner/presentation/widgets/add_banner_view.dart';
import '../../features/food_menu/presentation/views/food_categories_view.dart';

abstract class AppRouter {
  static const kLandingView = "/landingView";
  static const kOrdersView = "/ordersView";
  static const kFoodMenuView = "/foodcategoriesView";
  static const kCategoryItemsView = "/categoryItemsView";
  static const kBannersView = "/bannersView";
  static const kAddBannerView = "/addBannerView";

  static final Map<String, Widget> views = {
    kOrdersView: const OrdersView(),
    kFoodMenuView: const FoodCategoriesView(),
    kBannersView: const BannersView(),
    kAddBannerView: const AddEditBannerView(),
    kLandingView: const LandingView(),
  };
}
