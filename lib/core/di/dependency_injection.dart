import 'package:get_it/get_it.dart';
import 'package:restaurant_admin_panel/core/services/firebase/restaurant_firebase.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/repos/dashboard_repo.dart';
import 'package:restaurant_admin_panel/features/orders/data/repos/orders_repo.dart';

import '../services/paymob/paymob_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  //Paymob
  getIt.registerLazySingleton<PaymobService>(() => PaymobService());
  //Firebase
  getIt.registerLazySingleton<RestaurantFirebase>(() => RestaurantFirebase());
  //Repos
  getIt.registerLazySingleton<DashboardRepo>(() => DashboardRepo(getIt()));
  getIt.registerLazySingleton<OrdersRepo>(() => OrdersRepo(getIt(), getIt()));
}
