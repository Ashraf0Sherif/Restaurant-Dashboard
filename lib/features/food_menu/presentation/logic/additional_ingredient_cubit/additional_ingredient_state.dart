part of 'additional_ingredient_cubit.dart';

@immutable
sealed class AdditionalIngredientState {}

final class AdditionalIngredientInitial extends AdditionalIngredientState {}

final class AdditionalIngredientCurrentTypeChanged
    extends AdditionalIngredientState {
  final String currentType;

  AdditionalIngredientCurrentTypeChanged(this.currentType);
}
