<<<<<<< HEAD
import 'package:get_it/get_it.dart';
import 'package:restaurant_admin_panel/core/services/firebase/restaurant_firebase.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/repos/dashboard_repo.dart';
import 'package:restaurant_admin_panel/features/orders/data/repos/orders_repo.dart';

import '../services/paymob/paymob_service.dart';
=======

import 'package:get_it/get_it.dart';
import 'package:restaurant_admin_panel/core/services/firebase/restaurant_firebase.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/repos/dashboard_repo.dart';

>>>>>>> 0297c5245157796f12688b061e1a6579bf6a20e5

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
<<<<<<< HEAD
  //Paymob
  getIt.registerLazySingleton<PaymobService>(() => PaymobService());
  //Firebase
  getIt.registerLazySingleton<RestaurantFirebase>(() => RestaurantFirebase());
  //Repos
  getIt.registerLazySingleton<DashboardRepo>(() => DashboardRepo(getIt()));
  getIt.registerLazySingleton<OrdersRepo>(() => OrdersRepo(getIt(), getIt()));
=======
  //Firebase
  getIt.registerLazySingleton<RestaurantFirebase>(
      () => RestaurantFirebase());
  //Repos
  getIt.registerLazySingleton<DashboardRepo>(() => DashboardRepo(getIt()));
>>>>>>> 0297c5245157796f12688b061e1a6579bf6a20e5
}
