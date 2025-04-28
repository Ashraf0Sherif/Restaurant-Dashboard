import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../utils/responsive_views.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());
  int selectedIndex = 0;

  void changeView(ResponsiveView view) {
    emit(ChangeView(view: view));
  }
}
