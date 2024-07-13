part of 'food_menu_cubit.dart';

@immutable
abstract class FoodMenuState {}

class FoodMenuInitial extends FoodMenuState {}

class FoodMenuLoading extends FoodMenuState {}

class FoodMenuAddCategoryLoading extends FoodMenuState {}

class FoodMenuAddCategoryFailure extends FoodMenuState {
  final String errorMessage;

  FoodMenuAddCategoryFailure({required this.errorMessage});
}

class FoodMenuFailure extends FoodMenuState {
  final String errorMessage;

  FoodMenuFailure({required this.errorMessage});
}

class FoodMenuSuccess extends FoodMenuState {
  final List<CategoryModel> foodCategories;

  FoodMenuSuccess({required this.foodCategories});
}
