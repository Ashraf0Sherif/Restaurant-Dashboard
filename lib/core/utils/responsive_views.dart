import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/banner/presentation/views/banners_view_bloc_builder.dart';
import 'package:restaurant_admin_panel/features/banner/presentation/widgets/add_banner_view.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/views/dashboard_mobile_layout.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/views/dashboard_tablet_layout.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/add_edit_food_item/add_food_item_mobile_layout.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/add_edit_food_item/add_food_item_tablet_layout.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/add_edit_food_item/edit_food_item_mobile_layout.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/category_food_items/category_food_items_tablet_layout.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/add_edit_food_item/edit_food_item_tablet_layout.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/food_categories/food_categories_mobile_layout.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/food_item_details/food_item_details_mobile_layout.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/food_item_details/food_item_details_tablet_layout.dart';
import 'package:restaurant_admin_panel/features/orders/presentation/views/orders_view.dart';

import '../../features/banner/data/models/banner_model.dart';
import '../../features/food_menu/presentation/views/category_food_items/category_food_items_mobile_layout.dart';
import '../../features/food_menu/presentation/views/food_categories/food_categories_tablet_layout.dart';

class ResponsiveView {
  final Widget mobile;
  final Widget tablet;
  final int mobileMaxWidth, tabletMaxWidth;
  const ResponsiveView({
    required this.mobile,
    required this.tablet,
    this.mobileMaxWidth = 760,
    this.tabletMaxWidth = 1200,
  });
}

abstract class ResponsiveViews {
  static const ResponsiveView dashboard = ResponsiveView(
    mobile: DashboardMobileLayout(),
    tablet: DashboardTabletLayout(),
  );
  static const ResponsiveView orders = ResponsiveView(
    mobile: OrdersView(),
    tablet: OrdersView(),
  );
  static const ResponsiveView banners = ResponsiveView(
    mobile: BannersViewBlocBuilder(isMobile: true,),
    tablet: BannersViewBlocBuilder(),
  );
  static const ResponsiveView foodCategories = ResponsiveView(
    mobile: FoodCategoriesMobileLayout(),
    tablet: FoodCategoriesTabletLayout(),
  );
  static ResponsiveView categoryFoodItems(
      {required String categoryId, required List<FoodItem> foodItems, required String category}) {
    return ResponsiveView(
      mobile: CategoryFoodItemsMobileLayout(
        categoryId: categoryId,
        foodItems: foodItems, category: category,
      ),
      tablet: CategoryFoodItemsTabletLayout(
        categoryId: categoryId,
        foodItems: foodItems, category: category,
      ),
      mobileMaxWidth: 765,
    );
  }

  static ResponsiveView addEditBannerView(
      {BannerModel? banner}) {
    return ResponsiveView(
      mobile: AddEditBannerView(banner: banner),
      tablet: AddEditBannerView(banner: banner),
    );
  }

  static ResponsiveView addFoodView(
      {required String categoryId, required List<FoodItem> categoryItems, required String category}) {
    return ResponsiveView(
      mobile: AddFoodItemMobileLayout(
        categoryId: categoryId,
        categoryItems: categoryItems, category: category,
      ),
      tablet: AddFoodItemTabletLayout(
        categoryId: categoryId,
        categoryItems: categoryItems, category: category,
      ),
    );
  }

  static ResponsiveView editFoodView(
      {required FoodItem item,
      required String categoryId,
      required List<FoodItem> categoryItems,
      required String category}) {
    return ResponsiveView(
      mobile: EditFoodItemMobileLayout(
        item: item,
        categoryId: categoryId,
        categoryItems: categoryItems, category: category,
      ),
      tablet: EditFoodItemTabletLayout(
        item: item,
        categoryId: categoryId,
        categoryItems: categoryItems, category: category,
      ),
    );
  }

  static ResponsiveView foodItemDetails(
      {required FoodItem item,
      required String categoryId,
      required List<FoodItem> categoryItems, required String category}) {
    return ResponsiveView(
      mobile: FoodItemDetailsMobileLayout(
        item: item,
        categoryId: categoryId,
        categoryItems: categoryItems, category: category,
      ),
      tablet: FoodItemDetailsTabletLayout(
        item: item,
        categoryId: categoryId,
        categoryItems: categoryItems, category: category,
      ),
    );
  }
}
