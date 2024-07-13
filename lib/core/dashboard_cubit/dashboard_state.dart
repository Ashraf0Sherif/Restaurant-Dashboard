part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class EditBannerView extends DashboardState {
  final BannerModel banner;

  EditBannerView({required this.banner});
}

class CategoryFoodItems extends DashboardState {
  final List<FoodItem> foodItems;
  final String categoryId;

  CategoryFoodItems({required this.foodItems, required this.categoryId});
}

class DashboardChangeIndex extends DashboardState {
  final String view;
  final List<dynamic>? args;

  DashboardChangeIndex({required this.view, this.args});
}
