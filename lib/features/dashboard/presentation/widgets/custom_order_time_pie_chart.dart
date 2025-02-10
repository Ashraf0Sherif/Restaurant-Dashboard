import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/order_time_model.dart';

class CustomOrderTimePieChart extends StatefulWidget {
  const CustomOrderTimePieChart({
    super.key,
    required this.orderTimeData,
  });

  final OrderTimeModel orderTimeData;

  @override
  State<CustomOrderTimePieChart> createState() =>
      _CustomOrderTimePieChartState();
}

class _CustomOrderTimePieChartState extends State<CustomOrderTimePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              touchedIndex =
                  pieTouchResponse?.touchedSection?.touchedSectionIndex ?? -1;
            });
          },
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 65,
        startDegreeOffset: -90,
        sections: widget.orderTimeData.timeSlots
            .map(
              (slot) => PieChartSectionData(
                value: slot.percentage,
                title: '',
                color: slot.color,
                radius:
                    touchedIndex == widget.orderTimeData.timeSlots.indexOf(slot)
                        ? 50
                        : 40,
              ),
            )
            .toList(),
      ),
    );
  }
}
