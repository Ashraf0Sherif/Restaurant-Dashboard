part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}
class CategoryFoodItems extends DashboardState {
  final List<FoodItem>foodItems;
  final String categoryId;
  CategoryFoodItems({required this.foodItems, required this.categoryId});
}

class DashboardChangeIndex extends DashboardState {
  final String view;
  List<dynamic>? args;
  DashboardChangeIndex({required this.view, this.args});
}
