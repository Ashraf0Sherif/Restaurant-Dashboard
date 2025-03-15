part of 'navigation_cubit.dart';

@immutable
abstract class NavigationState {}

class NavigationInitial extends NavigationState {}

class NavigationLoading extends NavigationState {}

class ChangeView extends NavigationState {
  final ResponsiveView view;

  ChangeView({required this.view});
}
