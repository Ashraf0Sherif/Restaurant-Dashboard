import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/food_menu.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/widgets/category_food_items_view.dart';
import 'package:restaurant_admin_panel/features/orders/presentation/views/orders_view.dart';

import '../../features/banner/presentation/views/banners_view.dart';
import '../../features/banner/presentation/views/widgets/add_banner_view.dart';

abstract class AppRouter {
  static const kOrdersView = "/ordersView";
  static const kFoodMenuView = "/foodMenuView";
  static const kCategoryItemsView = "/categoryItemsView";
  static const kBannersView = "/bannersView";
  static const kAddBannerView = "/addBannerView";

  static final Map<String, Widget> views = {
    kOrdersView: const OrdersView(),
    kFoodMenuView: const FoodMenu(),
    kCategoryItemsView: const CategoryFoodItemsView(),
    kBannersView: const BannersView(),
    kAddBannerView: const AddBannerView(),
  };
}
