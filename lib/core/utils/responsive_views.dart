import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/features/banner/presentation/views/banners_view.dart';
import 'package:restaurant_admin_panel/features/banner/presentation/widgets/add_banner_view.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/views/dashboard_mobile_layout.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/views/dashboard_tablet_layout.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/add_food_view.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/category_food_items_view.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/edit_food_view.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/food_categories_view.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/food_item_details_mobile_layout.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/food_item_details_tablet_layout.dart';
import 'package:restaurant_admin_panel/features/orders/presentation/views/orders_view.dart';

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
    mobile: BannersView(),
    tablet: BannersView(),
  );
  static const ResponsiveView addEditBannerView =
      ResponsiveView(mobile: AddEditBannerView(), tablet: AddEditBannerView());
  static const ResponsiveView foodCategories = ResponsiveView(
    mobile: FoodCategoriesView(),
    tablet: FoodCategoriesView(),
  );
  static ResponsiveView categoryFoodItems(
      {required String categoryId, required List<FoodItem> foodItems}) {
    return ResponsiveView(
      mobile: CategoryFoodItemsView(
        categoryId: categoryId,
        foodItems: foodItems,
      ),
      tablet: CategoryFoodItemsView(
        categoryId: categoryId,
        foodItems: foodItems,
      ),
    );
  }

  static ResponsiveView addFoodView(
      {required String categoryId, required List<FoodItem> categoryItems}) {
    return ResponsiveView(
      mobile: AddFoodView(
        categoryId: categoryId,
        categoryItems: categoryItems,
      ),
      tablet: AddFoodView(
        categoryId: categoryId,
        categoryItems: categoryItems,
      ),
    );
  }

  static ResponsiveView editFoodView(
      {required FoodItem item,
      required String categoryId,
      required List<FoodItem> categoryItems}) {
    return ResponsiveView(
      mobile: EditFoodView(
        item: item,
        categoryId: categoryId,
        categoryItems: categoryItems,
      ),
      tablet: EditFoodView(
        item: item,
        categoryId: categoryId,
        categoryItems: categoryItems,
      ),
    );
  }

  static ResponsiveView foodItemDetails(
      {required FoodItem item,
      required String categoryId,
      required List<FoodItem> categoryItems}) {
    return ResponsiveView(
      mobile: FoodItemDetailsMobileLayout(
        item: item,
        categoryId: categoryId,
        categoryItems: categoryItems,
      ),
      tablet: FoodItemDetailsTabletLayout(
        item: item,
        categoryId: categoryId,
        categoryItems: categoryItems,
      ),
    );
  }
}
