part of 'dashboard_cubit.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = _DashboardInitial;
  const factory DashboardState.loading() = DashboardLoading;
  const factory DashboardState.loaded({required RevenueModel revenueData}) = DashboardLoaded;
  const factory DashboardState.error({required String message}) = DashboardError;
}
