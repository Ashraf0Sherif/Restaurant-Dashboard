import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_rate_section.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_and_most_ordered_food_section.dart';

class TabaletLayout extends StatelessWidget {
  const TabaletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 2,
          child: RevenueAndMostOrderFoodSection(),
        ),
        SizedBox(width: 10),
        Expanded(
          child: OrderTimeRateSection(),
        ),
      ],
    );
  }
}
