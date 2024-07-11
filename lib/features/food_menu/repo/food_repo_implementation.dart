import 'dart:typed_data';

import 'package:restaurant_admin_panel/features/food_menu/repo/food_repo.dart';
import 'package:restaurant_admin_panel/core/firebase/custom_firebase.dart';
import 'package:restaurant_admin_panel/core/firebase/firebase_exceptions.dart';
import 'package:restaurant_admin_panel/core/firebase/firebase_result.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';

import '../data/models/ingredient/ingredient.dart';

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
  Future<FirebaseResult<void>> addCategory(
      {required String title, required Uint8List? imageFile}) async {
    try {
      await customFirebase.addCategory(title: title, imageFile: imageFile!);
      return const FirebaseResult.success(null);
    } catch (error) {
      throw FirebaseExceptions.getFirebaseException(error);
    }
  }

  @override
  Future<FirebaseResult<void>> addFoodItem({required String categoryId,
    required String title,
    required String description,
    required String deliveryTime,
    required String price,
    required List<Uint8List> images,
    required List<Ingredient> ingredients}) async {
    try {
      await customFirebase.addFoodItem(
          categoryId: categoryId,
          title: title,
          description: description,
          deliveryTime: deliveryTime,
          price: price,
          images: images,
          ingredients: ingredients,);
      return const FirebaseResult.success(null);
    } catch (error) {
      throw FirebaseExceptions.getFirebaseException(error);
    }
  }

  @override
  Future<void> deleteCategory() {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<FirebaseResult<void>> deleteFoodItem({required String categoryId,required String foodId}) async{
    try{
      await customFirebase.deleteFoodItem(categoryId: categoryId, foodId: foodId);
      return const FirebaseResult.success(null);
    }catch(error){
      throw FirebaseExceptions.getFirebaseException(error);
    }
  }

  @override
  Future<void> updateCategory() {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

  @override
  Future<void> updateFoodItem() {
    // TODO: implement updateFoodItem
    throw UnimplementedError();
  }
}
