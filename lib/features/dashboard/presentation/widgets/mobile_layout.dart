import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/most_order_food_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_rate_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/tabalet_layout.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            children: [
              Expanded(child: OrderRateWidget()),
              Expanded(child: OrderTimeWidget()),
              // RevenueWidget(),
              //MostOrderFoodWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
