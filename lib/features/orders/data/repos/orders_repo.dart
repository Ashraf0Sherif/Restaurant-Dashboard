import 'package:restaurant_admin_panel/core/services/firebase/restaurant_firebase.dart';

import '../../../../core/services/firebase/firebase_exceptions.dart';
import '../../../../core/services/firebase/firebase_result.dart';
import '../../../../core/services/paymob/paymob_service.dart';
import '../models/receipt.dart';

class OrdersRepo {
  final RestaurantFirebase restaurantFirebase;

  final PaymobService paymobService;

  OrdersRepo(this.restaurantFirebase, this.paymobService);

  Future<FirebaseResult<List<Receipt>>> fetchReceipts() async {
    try {
      List<Receipt> receipts = await restaurantFirebase.fetchReceipts();
      List<Receipt> receiptsWithPaymentStatus =
          await paymobService.receiptsWithPaymentStatus(receipts);
      return FirebaseResult.success(receiptsWithPaymentStatus);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }
}
