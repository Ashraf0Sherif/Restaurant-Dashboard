import '../food_item/food_item.dart';

class CategoryModel {
  final String id;
  final String title;
  final String imageUrl;
  final List<FoodItem> foodItems;

  CategoryModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.foodItems});
}
