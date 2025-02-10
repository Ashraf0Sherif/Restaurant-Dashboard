import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/most_order_food_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_widget.dart';

class RevenueAndMostOrderFoodSection extends StatelessWidget {
  const RevenueAndMostOrderFoodSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(10),
        const Expanded(child: RevenueWidget()),
        verticalSpace(10),
        const MostOrderFoodWidget(),
      ],
    );
  }
}
