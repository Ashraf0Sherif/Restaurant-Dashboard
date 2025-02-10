import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/most_order_food_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_rate_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_and_most_ordered_food_section.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_drawer.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/tabalet_layout.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: CustomDrawer(),
        ),
        horizontalSpace(16),
        const Expanded(
          flex: 4,
          child: RevenueAndMostOrderFoodSection(),
        ),
        horizontalSpace(16),
        const Expanded(
          flex: 2,
          child: OrderTimeRateSection(),
        ),
      ],
    );
  }
}
