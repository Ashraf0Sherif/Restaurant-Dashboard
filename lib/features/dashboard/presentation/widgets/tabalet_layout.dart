import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_rate_section.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_and_most_ordered_food_section.dart';

class TabaletLayout extends StatelessWidget {
  const TabaletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(flex: 2, child: RevenueAndMostOrderFoodSection()),
              horizontalSpace(16),
              const Expanded(child: OrderTimeRateSection()),
              horizontalSpace(16),
            ],
          ),
        )
      ],
    );
  }
}
