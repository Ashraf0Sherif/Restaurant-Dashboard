import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/order_rate_model.dart';

import '../../../../core/services/firebase/firebase_exceptions.dart';
import '../../data/repos/dashboard_repo.dart';

part 'order_rate_state.dart';
part 'order_rate_cubit.freezed.dart';

class OrderRateCubit extends Cubit<OrderRateState> {
  final DashboardRepo dashboardRepo;
  OrderRateCubit(this.dashboardRepo) : super(const OrderRateState.initial());

  void fetchOrderRate() async {
    emit(const OrderRateState.loading());
    final response = await dashboardRepo.fetchOrderRate();
    response.when(
      success: (orderRate) {
        emit(OrderRateState.loaded(orderRate: orderRate));
      },
      failure: (error) {
        emit(OrderRateState.error(
            message: FirebaseExceptions.getErrorMessage(error)));
      },
    );
  }
}
