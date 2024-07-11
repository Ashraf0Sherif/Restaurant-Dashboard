import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_admin_panel/core/firebase/firebase_exceptions.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';

import '../../../data/models/ingredient/ingredient.dart';
import '../../../repo/food_repo_implementation.dart';
import '../../../../../core/firebase/custom_firebase.dart';

part 'food_menu_state.dart';

class FoodMenuCubit extends Cubit<FoodMenuState> {
  final FoodRepoImplementation foodRepoImplementation;
  List<CategoryModel>? categories;

  FoodMenuCubit(this.foodRepoImplementation) : super(FoodMenuInitial());

  Future<void> getCategories() async {
    emit(FoodMenuLoading());

    var response = await foodRepoImplementation.getCategories();
    response.when(
      success: (categories) {
        this.categories = categories;
        emit(FoodMenuSuccess());
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
      success: (done) {
        getCategories();
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
      required String title,
      required String description,
      required String deliveryTime,
      required String price,
      required List<Uint8List> images,
      required List<Ingredient> ingredients}) async {
    emit(FoodMenuLoading());
    var response = await foodRepoImplementation.addFoodItem(
        categoryId: categoryId,
        title: title,
        description: description,
        deliveryTime: deliveryTime,
        price: price,
        images: images,
        ingredients: ingredients);
    response.when(
      success: (done) {
        getCategories();
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
        getCategories();
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(FoodMenuFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }
}
