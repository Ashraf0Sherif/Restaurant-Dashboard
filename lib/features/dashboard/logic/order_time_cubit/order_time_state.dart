part of 'order_time_cubit.dart';

@freezed
class OrderTimeState with _$OrderTimeState {
  const factory OrderTimeState.initial() = _OrderTimeInitial;

  const factory OrderTimeState.loading() = OrderTimeLoading;

  const factory OrderTimeState.loaded(
      {required OrderTimeModel orderTime}) = OrderTimeLoaded;

  const factory OrderTimeState.error({required String message}) =
      OrderTimeError;
}
