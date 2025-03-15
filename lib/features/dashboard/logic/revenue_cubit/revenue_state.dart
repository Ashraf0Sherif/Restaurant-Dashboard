part of 'revenue_cubit.dart';

@freezed
class RevenueState with _$RevenueState {
  const factory RevenueState.initial() = _RevenueInitial;
  const factory RevenueState.loading() = RevenueLoading;
  const factory RevenueState.loaded({required RevenueModel revenueData}) = RevenueLoaded;
  const factory RevenueState.error({required String message}) = RevenueError;
}
