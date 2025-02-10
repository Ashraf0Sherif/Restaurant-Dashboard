import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/order_time_model.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_order_time_pie_chart.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_header.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_slot.dart';

class OrderTimeWidget extends StatelessWidget {
  final OrderTimeModel orderTimeData;

  const OrderTimeWidget({
    super.key,
    this.orderTimeData = const OrderTimeModel(
      title: 'Order Time',
      dateRange: 'From 1-6 Dec, 2020',
      timeSlots: [
        TimeSlot(
          time: '12am-4am',
          percentage: 40,
          color: ColorsStyles.kPrimaryColor,
        ),
        TimeSlot(
          time: '4am-8am',
          percentage: 30,
          color: Color.fromARGB(255, 100, 126, 169),
        ),
        TimeSlot(
          time: '8am-12pm',
          percentage: 15,
          color: ColorsStyles.kSecondaryColor,
        ),
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrderTimeHeader(orderTimeData: orderTimeData),
        const SizedBox(height: 20),
        Expanded(
          child: CustomOrderTimePieChart(orderTimeData: orderTimeData),
        ),
        const SizedBox(height: 20),
        ...orderTimeData.timeSlots.map(
          (slot) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: OrderTimeSlot(
              slot: slot,
            ),
          ),
        ),
      ],
    );
  }
}
