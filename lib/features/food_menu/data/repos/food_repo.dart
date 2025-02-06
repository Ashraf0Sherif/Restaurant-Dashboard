import 'dart:typed_data';

import '../../../../core/firebase/firebase_result.dart';
import '../models/category/category_model.dart';
import '../models/food_item/food_item.dart';

abstract class FoodRepo {
  Future<FirebaseResult<List<CategoryModel>>> getCategories();

  Future<void> addCategory(
      {required String title,
      required String arabicTitle,
      required Uint8List? imageFile});

  Future<void> deleteCategory({required String categoryId});

  Future<void> updateCategory(
      {required CategoryModel category, required Uint8List imageFile});

  Future<FirebaseResult<FoodItem>> addFoodItem(
      {required String categoryId,
      required FoodItem foodItem,
      required List<Uint8List> images});

  Future<void> deleteFoodItem(
      {required String categoryId, required String foodId});

  Future<void> updateFoodItem(
      {required String categoryId,
      required FoodItem foodItem,
      required List<Uint8List> images});
}
