import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/most_order_food_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_rate_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_widget.dart';

class TabaletLayout extends StatelessWidget {
  const TabaletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              verticalSpace(10),
              const Expanded(child: RevenueWidget()),
              verticalSpace(10),
              const MostOrderFoodWidget(),
            ],
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          flex: 2,
          child: OrderTimeRateSection(),
        ),
      ],
    );
  }
}

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
      child: const Column(
        children: [
          SizedBox(height: 10),
          Expanded(child: OrderTimeWidget()),
          Divider(color: Colors.grey),
          Expanded(child: OrderRateWidget()),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
