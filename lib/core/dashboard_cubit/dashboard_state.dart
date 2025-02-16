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

class ChangeView extends DashboardState {
  final ResponsiveView view;

  ChangeView({required this.view});
}

class ResponsiveView {
  final Widget mobile;
  final Widget tablet;

  const ResponsiveView({
    required this.mobile,
    required this.tablet,
  });
}
