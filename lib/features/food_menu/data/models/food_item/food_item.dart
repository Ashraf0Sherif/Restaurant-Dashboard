import 'package:restaurant_admin_panel/features/food_menu/data/models/ingredient/extra_ingredient.dart';

import '../ingredient/ingredient.dart';

class FoodItem {
  String id;
  String title;
  String description;
  String price;
  String deliverTime;
  List<String> images;
  List<Ingredient> ingredients;
  List<ExtraIngredient> extraIngredients;

  FoodItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.deliverTime,
    required this.images,
    required this.ingredients,
    required this.extraIngredients,
  });
}
