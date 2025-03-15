import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/revenue_model.dart';

class CustomRevenueBarChart extends StatefulWidget {
  const CustomRevenueBarChart({super.key, required this.revenueData});
  final RevenueModel revenueData;

  @override
  State<CustomRevenueBarChart> createState() => _CustomRevenueBarChartState();
}

class _CustomRevenueBarChartState extends State<CustomRevenueBarChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: widget.revenueData.getMaxRevenue(),
          barGroups: List.generate(
            widget.revenueData.weeklyData.length,
            (index) => _generateBarGroup(index),
          ),
          barTouchData: BarTouchData(
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              setState(() {
                touchedIndex = barTouchResponse?.spot?.touchedBarGroupIndex ?? -1;
              });
            },
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.grey[800]!,
              tooltipRoundedRadius: 8,
              fitInsideHorizontally: true,
              fitInsideVertically: true,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  if (value < 0 || value >= widget.revenueData.weeklyData.length) {
                    return const Text('');
                  }
                  final isSelected = value.toInt() == touchedIndex;
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      widget.revenueData.weeklyData[value.toInt()].day,
                      style: TextStyle(
                        color: isSelected ? ColorsStyles.kPrimaryColor : Colors.grey[400],
                        fontSize: isSelected ? 14 : 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  );
                },
                interval: widget.revenueData.getInterval(),
                reservedSize: 30,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: widget.revenueData.getInterval(),
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.1),
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
          ),
          borderData: FlBorderData(
            show: false,
          ),
        ),
      ),
    );
  }

  BarChartGroupData _generateBarGroup(int x) {
    final dayData = widget.revenueData.weeklyData[x];
    final isSelected = x == touchedIndex;
    final width = isSelected ? 8.0 : 6.0;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: dayData.currentWeekRevenue,
          color: ColorsStyles.kPrimaryColor.withOpacity(isSelected ? 1 : 0.8),
          width: width,
          borderRadius: BorderRadius.zero,
        ),
        BarChartRodData(
          toY: dayData.lastWeekRevenue,
          color: Colors.grey[300]?.withOpacity(isSelected ? 1 : 0.8),
          width: width,
          borderRadius: BorderRadius.zero,
        ),
      ],
      barsSpace: 4,
    );
  }
}
