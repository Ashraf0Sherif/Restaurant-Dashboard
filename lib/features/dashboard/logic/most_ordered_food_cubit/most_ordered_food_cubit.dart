import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';

import '../../../../core/services/firebase/firebase_exceptions.dart';
import '../../data/models/most_ordered_food_model.dart';
import '../../data/repos/dashboard_repo.dart';

part 'most_ordered_food_state.dart';

part 'most_ordered_food_cubit.freezed.dart';

class MostOrderedFoodCubit extends Cubit<MostOrderedFoodState> {
  final DashboardRepo dashboardRepo;

  MostOrderedFoodCubit(this.dashboardRepo)
      : super(const MostOrderedFoodState.initial());

  void fetchMostOrderedFood() async {
    emit(const MostOrderedFoodState.loading());
    final response = await dashboardRepo.fetchMostOrderedFood();
    response.when(
      success: (mostOrderedFood) {
        print(mostOrderedFood);
        emit(MostOrderedFoodState.loaded(mostOrderedFood: mostOrderedFood));
      },
      failure: (error) {
        emit(MostOrderedFoodState.error(
            message: FirebaseExceptions.getErrorMessage(error)));
      },
    );
  }
}
