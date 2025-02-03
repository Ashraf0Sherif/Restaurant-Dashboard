import '../food_item/food_item.dart';

class CategoryModel {
  String id;
  String title;
  String arabicTitle;
  String imageUrl;
  List<FoodItem> foodItems;

  CategoryModel(
      {required this.id,
      required this.title,
      required this.arabicTitle,
      required this.imageUrl,
      required this.foodItems});
}
