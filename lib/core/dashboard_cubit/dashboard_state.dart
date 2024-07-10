part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardChangeIndex extends DashboardState {
  final String view;

  DashboardChangeIndex({required this.view});
}
