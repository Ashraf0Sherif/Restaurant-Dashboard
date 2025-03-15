import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_admin_panel/features/banner/data/models/banner_model.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';

import '../utils/responsive_views.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());
  int selectedIndex = 0;

  void changeView(ResponsiveView view) {
    emit(ChangeView(view: view));
  }
}
