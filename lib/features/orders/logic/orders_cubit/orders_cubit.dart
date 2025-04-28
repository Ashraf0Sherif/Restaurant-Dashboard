import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_admin_panel/features/orders/data/models/receipt.dart';
import 'package:restaurant_admin_panel/features/orders/data/repos/orders_repo.dart';

import '../../../../core/services/firebase/firebase_exceptions.dart';

part 'orders_cubit.freezed.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo ordersRepo;

  OrdersCubit(this.ordersRepo) : super(const OrdersState.initial());

  void fetchReceipts() async {
    emit(const OrdersState.loading());
    final response = await ordersRepo.fetchReceipts();
    response.when(
      success: (receipts) {
        emit(OrdersState.loaded(receipts: receipts));
      },
      failure: (error) {
        emit(OrdersState.error(
            message: FirebaseExceptions.getErrorMessage(error)));
      },
    );
  }
}
