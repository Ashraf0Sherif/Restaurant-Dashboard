
import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/order_time_model.dart';

class OrderTimeSlot extends StatelessWidget {
  const OrderTimeSlot({
    super.key,
    required this.slot,
  });
  final TimeSlot slot;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: slot.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          slot.time,
          style: TextStyle(
            fontSize: FontStyles.getResponsiveFontSize(context, 14),
            color: Colors.grey[400],
          ),
        ),
        const Spacer(),
        Text(
          '${slot.percentage.toInt()}%',
          style: TextStyle(
            fontSize: FontStyles.getResponsiveFontSize(context, 14),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
