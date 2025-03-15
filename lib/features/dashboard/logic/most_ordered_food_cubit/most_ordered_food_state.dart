part of 'most_ordered_food_cubit.dart';

@freezed
class MostOrderedFoodState with _$MostOrderedFoodState {
  const factory MostOrderedFoodState.initial() = _MostOrderedFoodInitial;
  const factory MostOrderedFoodState.loading() = MostOrderedFoodLoading;
  const factory MostOrderedFoodState.loaded({required List<MostOrderedFoodModel> mostOrderedFood}) = MostOrderedFoodLoaded;
  const factory MostOrderedFoodState.error({required String message}) = MostOrderedFoodError;
}
