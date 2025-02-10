import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/most_order_food_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_rate_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_widget.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const AspectRatio(
              aspectRatio: 1.5,
              child: RevenueWidget(),
            ),
            verticalSpace(10),
            const MostOrderFoodWidget(),
            verticalSpace(10),
            const BackGroundContainer(
              child: AspectRatio(
                aspectRatio: 1,
                child: OrderTimeWidget(),
              ),
            ),
            verticalSpace(10),
            const BackGroundContainer(
              child: AspectRatio(
                aspectRatio: 1.3,
                child: OrderRateWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
