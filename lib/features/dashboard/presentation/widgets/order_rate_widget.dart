import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/order_rate_model.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_order_rate_line_chart.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_rate_header.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/this_last_week.dart';

class OrderRateWidget extends StatelessWidget {
  final OrderRateModel orderRateData;

  const OrderRateWidget({
    super.key,
    this.orderRateData = const OrderRateModel(
      totalOrders: '2,568',
      percentageChange: -2.1,
      weekOrders: [
        DailyOrder(day: 'Mon', currentWeekOrders: 4.0, lastWeekOrders: 3.0),
        DailyOrder(day: 'Tue', currentWeekOrders: 6.0, lastWeekOrders: 5.0),
        DailyOrder(day: 'Wed', currentWeekOrders: 8.0, lastWeekOrders: 7.0),
        DailyOrder(day: 'Thu', currentWeekOrders: 4.0, lastWeekOrders: 5.0),
        DailyOrder(day: 'Fri', currentWeekOrders: 10.0, lastWeekOrders: 9.0),
        DailyOrder(day: 'Sat', currentWeekOrders: 5.0, lastWeekOrders: 6.0),
        DailyOrder(day: 'Sun', currentWeekOrders: 7.0, lastWeekOrders: 8.0),
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrderRateHeader(orderRateData: orderRateData),
        const SizedBox(height: 20),
        Expanded(
          child: CustomOrderRateLineChart(orderRateData: orderRateData),
        ),
        verticalSpace(10),
        const ThisLastWeek(),
      ],
    );
  }
}
