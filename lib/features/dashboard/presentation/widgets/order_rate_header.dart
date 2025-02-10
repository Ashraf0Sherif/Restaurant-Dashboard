import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/order_rate_model.dart';

class OrderRateHeader extends StatelessWidget {
  const OrderRateHeader({super.key, required this.orderRateData});
  final OrderRateModel orderRateData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order',
          style: TextStyle(
            fontSize: FontStyles.getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          orderRateData.totalOrders,
          style: TextStyle(
            fontSize: FontStyles.getResponsiveFontSize(context, 24),
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Icon(
              orderRateData.percentageChange >= 0
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
              color: orderRateData.percentageChange >= 0
                  ? Colors.green
                  : Colors.red,
              size: FontStyles.getResponsiveFontSize(context, 16),
            ),
            Text(
              '${orderRateData.percentageChange.abs()}%',
              style: TextStyle(
                color: orderRateData.percentageChange >= 0
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: FontStyles.getResponsiveFontSize(context, 14),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'vs last week',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: FontStyles.getResponsiveFontSize(context, 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Sales from 1-6 Dec, 2020',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: FontStyles.getResponsiveFontSize(context, 14),
          ),
        ),
      ],
    );
  }
}
