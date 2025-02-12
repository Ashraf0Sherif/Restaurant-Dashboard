import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'additional_ingredient_state.dart';

class AdditionalIngredientCubit extends Cubit<AdditionalIngredientState> {
  AdditionalIngredientCubit() : super(AdditionalIngredientInitial());

  void emitChangeCurrentType({required String currentType}) {
    emit(AdditionalIngredientCurrentTypeChanged(currentType));
  }
}
