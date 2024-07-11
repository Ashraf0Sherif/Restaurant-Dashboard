import 'dart:typed_data';

import '../data/models/ingredient/ingredient.dart';

abstract class FoodRepo {
  Future<void> getCategories();

  Future<void> addCategory(
      {required String title, required Uint8List? imageFile});

  Future<void> deleteCategory({required String categoryId});

  Future<void> updateCategory(
      {required String categoryId, String? title, Uint8List? imageFile});

  Future<void> addFoodItem(
      {required String categoryId,
      required String title,
      required String description,
      required String deliveryTime,
      required String price,
      required List<Uint8List> images,
      required List<Ingredient> ingredients});

  Future<void> deleteFoodItem(
      {required String categoryId, required String foodId});

  Future<void> updateFoodItem(
      {required String categoryId,
      required String title,
      required String description,
      required String deliveryTime,
      required String price,
      required List<Uint8List> images,
      required List<Ingredient> ingredients,
      required String foodId});
}
