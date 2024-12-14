import 'ingredient.dart';

class ExtraIngredient extends Ingredient {
  ExtraIngredient({
    required super.title,
    required this.price,
  });

  final String price;
}
