import '../ingredient/ingredient.dart';

class FoodItem {
  String id;
  String title;
  String description;
  String price;
  String deliverTime;
  List<String> images;
  List<Ingredient> ingredients;

  FoodItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.deliverTime,
    required this.images,
    required this.ingredients,
  });
}
