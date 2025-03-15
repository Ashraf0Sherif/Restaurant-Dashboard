import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/order_time_model.dart';

import '../../../../core/services/firebase/firebase_exceptions.dart';
import '../../data/repos/dashboard_repo.dart';

part 'order_time_state.dart';
part 'order_time_cubit.freezed.dart';

class OrderTimeCubit extends Cubit<OrderTimeState> {
  final DashboardRepo dashboardRepo;
  OrderTimeCubit(this.dashboardRepo) : super(const OrderTimeState.initial());

  void fetchOrderTime() async {
    emit(const OrderTimeState.loading());
    final response = await dashboardRepo.fetchOrderTime();
    response.when(
      success: (orderTime) {
        emit(OrderTimeState.loaded(orderTime: orderTime));
      },
      failure: (error) {
        emit(OrderTimeState.error(
            message: FirebaseExceptions.getErrorMessage(error)));
      },
    );
  }
}
