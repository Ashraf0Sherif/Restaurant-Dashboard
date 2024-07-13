import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_admin_panel/features/banner/data/models/banner_model.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  void gotoCategoryFoodItems(
      {required String categoryId, required List<FoodItem> foodItems}) {
    emit(CategoryFoodItems(foodItems: foodItems, categoryId: categoryId));
  }

  void gotoEditBanner({required BannerModel banner}) {
    emit(EditBannerView(banner: banner));
  }

  void changeView(String view) {
    emit(DashboardChangeIndex(view: view));
  }
}
