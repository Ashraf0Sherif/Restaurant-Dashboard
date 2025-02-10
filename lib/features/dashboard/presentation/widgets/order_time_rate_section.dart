import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_rate_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_widget.dart';

class OrderTimeRateSection extends StatelessWidget {
  const OrderTimeRateSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF2C2C2C),
      ),
      child: Column(
        children: [
          verticalSpace(10),
          const Expanded(child: OrderTimeWidget()),
          const Divider(color: Colors.grey),
          const Expanded(child: OrderRateWidget()),
          verticalSpace(10),
        ],
      ),
    );
  }
}
