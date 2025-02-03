import 'ingredient.dart';

class ExtraIngredient extends Ingredient {
  ExtraIngredient({
    required super.title,
    required this.price,
    required super.arabicTitle,
  });

  final String price;
}
