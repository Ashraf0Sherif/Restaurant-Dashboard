import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/food_menu.dart';
import 'package:restaurant_admin_panel/features/orders/presentation/views/orders_view.dart';

import '../../features/banner/presentation/views/banners_view.dart';
import '../../features/banner/presentation/widgets/add_banner_view.dart';

abstract class AppRouter {
  static const kOrdersView = "/ordersView";
  static const kFoodMenuView = "/foodMenuView";
  static const kCategoryItemsView = "/categoryItemsView";
  static const kBannersView = "/bannersView";
  static const kAddBannerView = "/addBannerView";

  static final Map<String, Widget> views = {
    kOrdersView: const OrdersView(),
    kFoodMenuView: const FoodMenu(),
    kBannersView: const BannersView(),
    kAddBannerView: AddEditBannerView(),
  };
}
