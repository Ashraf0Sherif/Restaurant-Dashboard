import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_admin_panel/core/firebase/firebase_exceptions.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';

import '../../../data/models/food_item/food_item.dart';
import '../../../repo/food_repo_implementation.dart';

part 'food_menu_state.dart';

class FoodMenuCubit extends Cubit<FoodMenuState> {
  final FoodRepoImplementation foodRepoImplementation;
  List<CategoryModel> categories = [];

  FoodMenuCubit(this.foodRepoImplementation) : super(FoodMenuInitial());

  Future<void> getCategories() async {
    emit(FoodMenuLoading());

    var response = await foodRepoImplementation.getCategories();
    response.when(
      success: (categories) {
        this.categories = categories;
        emit(FoodMenuSuccess(foodCategories: categories));
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(FoodMenuFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }

  Future<void> addCategory(
      {required String title, required Uint8List? imageFile}) async {
    emit(FoodMenuLoading());
    var response = await foodRepoImplementation.addCategory(
        title: title, imageFile: imageFile!);
    response.when(
      success: (category) {
        categories.insert(0, category);
        emit(FoodMenuSuccess(foodCategories: categories));
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(FoodMenuFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }

  Future<void> updateCategory(
      {required CategoryModel category,Uint8List? imageFile}) async {
    emit(FoodMenuLoading());
    var response = await foodRepoImplementation.updateCategory(
        category: category, imageFile: imageFile);
    response.when(
      success: (category) {
        int categoryIndex =
            categories.indexWhere((element) => element.id == category.id);
        categories[categoryIndex] = category;
        emit(FoodMenuSuccess(foodCategories: categories));
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(FoodMenuFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }

  Future<void> deleteCategory({required String categoryId}) async {
    emit(FoodMenuLoading());
    var response =
        await foodRepoImplementation.deleteCategory(categoryId: categoryId);
    response.when(
      success: (done) {
        int categoryIndex =
            categories.indexWhere((element) => element.id == categoryId);
        categories.removeAt(categoryIndex);
        emit(FoodMenuSuccess(foodCategories: categories));
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(FoodMenuFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }

  Future<void> addFoodItem(
      {required String categoryId,
      required FoodItem foodItem,
      required List<Uint8List> images}) async {
    emit(FoodMenuLoading());
    var response = await foodRepoImplementation.addFoodItem(
        categoryId: categoryId, foodItem: foodItem, images: images);
    response.when(
      success: (foodItem) {
        int categoryIndex =
            categories.indexWhere((element) => element.id == categoryId);
        categories[categoryIndex].foodItems.insert(0, foodItem);
        emit(FoodMenuSuccess(foodCategories: categories));
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(FoodMenuFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }

  Future<void> deleteFoodItem(
      {required String categoryId, required String foodId}) async {
    emit(FoodMenuLoading());
    var response = await foodRepoImplementation.deleteFoodItem(
        categoryId: categoryId, foodId: foodId);
    response.when(
      success: (done) {
        int categoryIndex =
            categories.indexWhere((element) => element.id == categoryId);
        int foodIndex = categories[categoryIndex]
            .foodItems
            .indexWhere((element) => element.id == foodId);
        categories[categoryIndex].foodItems.removeAt(foodIndex);
        emit(FoodMenuSuccess(foodCategories: categories));
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(FoodMenuFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }

  Future<void> updateFoodItem(
      {required String categoryId,
      required FoodItem foodItem,
      required List<Uint8List> images}) async {
    emit(FoodMenuLoading());
    var response = await foodRepoImplementation.updateFoodItem(
        categoryId: categoryId, foodItem: foodItem, images: images);
    response.when(
      success: (foodItem) {
        int categoryIndex =
            categories.indexWhere((element) => element.id == categoryId);
        int foodIndex = categories[categoryIndex]
            .foodItems
            .indexWhere((element) => element.id == foodItem.id);
        categories[categoryIndex].foodItems[foodIndex] = foodItem;
        emit(FoodMenuSuccess(foodCategories: categories));
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(FoodMenuFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }
}
