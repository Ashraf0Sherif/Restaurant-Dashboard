import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../features/orders/data/models/receipt.dart';
import '../../helpers/assets.dart';

class PaymobService {
  final Dio _dio = Dio();
  final String _url = dotenv.env["BASE_URL"]!;
  final String _paymentKey = dotenv.env["PAYMENT_KEY"]!;
  final String _authTokenURL = dotenv.env["AUTH_TOKEN_URL"]!;
  final String _transactionInquiryURL = dotenv.env["TRANSACTION_INQUIRY_URL"]!;
  final String _apiKey = dotenv.env["API_KEY"]!;

  Future<String> getAuthToken() async {
    final response = await _dio.post(
      _authTokenURL,
      data: {"api_key": _apiKey},
    );
    return response.data['token'];
  }

  String _extractStatus(Map<String, dynamic> transactionData) {
    final bool isSuccess = transactionData['success'] == true;
    final bool isPending = transactionData['pending'] == true;
    final bool isCancelled = transactionData['is_voided'] == true ||
        transactionData['is_void'] == true ||
        transactionData['is_refunded'] == true;

    if (isSuccess) {
      return 'success';
    } else if (isPending) {
      return 'pending';
    } else if (isCancelled) {
      return 'cancelled';
    } else {
      return 'processing';
    }
  }

  Future<List<Receipt>> receiptsWithPaymentStatus(
      List<Receipt> receipts) async {
    final authToken = await getAuthToken();
    for (var receipt in receipts) {
      final response = await _dio.post(
        _transactionInquiryURL,
        data: {
          "order_id": receipt.orderId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $authToken",
            "Content-Type": "application/json",
            "Accept": "*/*",
          },
        ),
      );
      receipt.amountCents = response.data['amount_cents'];
      receipt.amountCents = (receipt.amountCents! / 100).ceil();
      receipt.paymentId = response.data['id'];
      receipt.date = response.data['created_at']!.split("T")[0];
      receipt.cardType = response.data['data']['card_type'];
      receipt.cardNumber = response.data['data']['card_num'];
      Map<String, String> cardImageMap = {
        'MASTERCARD': AssetsData.kMasterCardSVG,
        'VISA': AssetsData.kVisaSVG,
      };
      receipt.cardImage = cardImageMap[receipt.cardType];
      receipt.cardImage ??= AssetsData.kInvalidCardSVG;
      receipt.status = _extractStatus(response.data);
    }
    receipts
        .sort((receipt1, receipt2) => receipt2.date!.compareTo(receipt1.date!));
    return receipts;
  }
}
