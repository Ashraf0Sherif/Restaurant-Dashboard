part of 'orders_cubit.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = _OrdersInitial;

  const factory OrdersState.loading() = OrdersLoading;

  const factory OrdersState.loaded({required List<Receipt> receipts}) =
      OrdersLoaded;

  const factory OrdersState.error({required String message}) = OrdersError;
}
