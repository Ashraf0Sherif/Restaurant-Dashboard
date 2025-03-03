import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_admin_panel/features/banner/data/models/banner_model.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';

import '../utils/responsive_views.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());
  int selectedIndex = 0;
  void gotoCategoryFoodItems(
      {required String categoryId, required List<FoodItem> foodItems}) {
    emit(CategoryFoodItems(foodItems: foodItems, categoryId: categoryId));
  }

  void gotoEditBanner({required BannerModel banner}) {
    emit(EditBannerView(banner: banner));
  }

  void changeView(ResponsiveView view) {
    emit(ChangeView(view: view));
  }
}
