import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/order_time_model.dart';

class OrderTimeHeader extends StatelessWidget {
  const OrderTimeHeader({super.key, required this.orderTimeData});
  final OrderTimeModel orderTimeData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              orderTimeData.title,
              style: TextStyle(
                fontSize: FontStyles.getResponsiveFontSize(context, 18),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          orderTimeData.dateRange,
          style: TextStyle(
            fontSize: FontStyles.getResponsiveFontSize(context, 14),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
