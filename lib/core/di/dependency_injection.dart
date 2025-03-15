
import 'package:get_it/get_it.dart';
import 'package:restaurant_admin_panel/core/services/firebase/restaurant_firebase.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/repos/dashboard_repo.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  //Firebase
  getIt.registerLazySingleton<RestaurantFirebase>(
      () => RestaurantFirebase());
  //Repos
  getIt.registerLazySingleton<DashboardRepo>(() => DashboardRepo(getIt()));
}
