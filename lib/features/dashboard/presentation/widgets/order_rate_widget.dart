import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/order_rate_model.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_order_rate_line_chart.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_rate_header.dart';

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
        Row(
          children: [
            _buildLegendItem(context, 'This Week', ColorsStyles.kPrimaryColor),
            const SizedBox(width: 16),
            _buildLegendItem(
                context, 'Last Week', ColorsStyles.kSecondaryColor),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(BuildContext context, String title, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: FontStyles.getResponsiveFontSize(context, 14),
          ),
        ),
      ],
    );
  }
}
