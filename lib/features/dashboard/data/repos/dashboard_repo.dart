import 'package:restaurant_admin_panel/core/services/firebase/firebase_exceptions.dart';
import 'package:restaurant_admin_panel/core/services/firebase/firebase_result.dart';

import '../../../../core/services/firebase/restaurant_firebase.dart';
import '../models/revenue_model.dart';

class DashboardRepo {
  final RestaurantFirebase restaurantFirebase;
  DashboardRepo(this.restaurantFirebase);
  Future<FirebaseResult<RevenueModel>> fetchWeeklyRevenueData() async {
    try {
      RevenueModel revenueModel = await restaurantFirebase.getRevenue();
      return FirebaseResult.success(revenueModel);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }
}
