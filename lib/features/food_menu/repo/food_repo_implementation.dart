import 'dart:typed_data';

import 'package:restaurant_admin_panel/core/firebase/custom_firebase.dart';
import 'package:restaurant_admin_panel/core/firebase/firebase_exceptions.dart';
import 'package:restaurant_admin_panel/core/firebase/firebase_result.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/repo/food_repo.dart';

class FoodRepoImplementation implements FoodRepo {
  final CustomFirebase customFirebase;

  FoodRepoImplementation(this.customFirebase);

  @override
  Future<FirebaseResult<List<CategoryModel>>> getCategories() async {
    try {
      var response = await customFirebase.getCategories();
      return FirebaseResult.success(response);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<CategoryModel>> addCategory(
      {required String title, required Uint8List? imageFile}) async {
    try {
      var response =
          await customFirebase.addCategory(title: title, imageFile: imageFile!);
      return FirebaseResult.success(response);
    } catch (error) {
      throw FirebaseExceptions.getFirebaseException(error);
    }
  }

  @override
  Future<FirebaseResult<FoodItem>> addFoodItem(
      {required String categoryId,
      required FoodItem foodItem,
      required List<Uint8List> images}) async {
    try {
      var response = await customFirebase.addFoodItem(
          foodItem: foodItem, categoryId: categoryId, images: images);
      return FirebaseResult.success(response);
    } catch (error) {
      return FirebaseResult.failure(
        FirebaseExceptions.getFirebaseException(error),
      );
    }
  }

  @override
  Future<FirebaseResult<void>> deleteCategory(
      {required String categoryId}) async {
    try {
      await customFirebase.deleteCategory(categoryId: categoryId);
      return const FirebaseResult.success(null);
    } catch (error) {
      throw FirebaseExceptions.getFirebaseException(error);
    }
  }

  @override
  Future<FirebaseResult<void>> deleteFoodItem(
      {required String categoryId, required String foodId}) async {
    try {
      await customFirebase.deleteFoodItem(
          categoryId: categoryId, foodId: foodId);
      return const FirebaseResult.success(null);
    } catch (error) {
      throw FirebaseExceptions.getFirebaseException(error);
    }
  }

  @override
  Future<FirebaseResult<CategoryModel>> updateCategory(
      {required CategoryModel category,Uint8List? imageFile}) async {
    try {
      var response = await customFirebase.updateCategory(
          category: category, imageFile: imageFile);
      return FirebaseResult.success(response);
    } catch (error) {
      throw FirebaseExceptions.getFirebaseException(error);
    }
  }

  @override
  Future<FirebaseResult<FoodItem>> updateFoodItem(
      {required String categoryId,
      required FoodItem foodItem,
      required List<Uint8List> images}) async {
    try {
      var response = await customFirebase.updateFoodItem(
          categoryId: categoryId, foodItem: foodItem, images: images);
      return FirebaseResult.success(response);
    } catch (error) {
      throw FirebaseExceptions.getFirebaseException(error);
    }
  }
}
