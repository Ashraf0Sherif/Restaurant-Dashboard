import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/order_rate_model.dart';

class CustomOrderRateLineChart extends StatefulWidget {
  const CustomOrderRateLineChart({
    super.key,
    required this.orderRateData,
  });

  final OrderRateModel orderRateData;

  @override
  State<CustomOrderRateLineChart> createState() => _CustomOrderRateLineChartState();
}

class _CustomOrderRateLineChartState extends State<CustomOrderRateLineChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchCallback: (FlTouchEvent event, lineTouchResponse) {
            setState(() {
              touchedIndex =
                  lineTouchResponse?.lineBarSpots?.first.x.toInt() ?? -1;
            });
          },
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.grey[800]!,
            tooltipRoundedRadius: 8,
            fitInsideHorizontally: true,
            fitInsideVertically: true,
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 2,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.15),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value < 0 || value >= 7) return const SizedBox();
                final isSelected = value.toInt() == touchedIndex;
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    widget.orderRateData.weekOrders[value.toInt()].day,
                    style: TextStyle(
                      color: isSelected
                          ? ColorsStyles.kPrimaryColor
                          : Colors.grey[400],
                      fontSize: FontStyles.getResponsiveFontSize(
                          context, isSelected ? 14 : 12),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 2,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: FontStyles.getResponsiveFontSize(context, 12),
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: widget.orderRateData.weekOrders.length - 1,
        minY: 0,
        maxY: 10,
        lineBarsData: [
          // Current Week Line
          LineChartBarData(
            spots: List.generate(
              widget.orderRateData.weekOrders.length,
              (index) => FlSpot(
                index.toDouble(),
                widget.orderRateData.weekOrders[index].currentWeekOrders,
              ),
            ),
            isCurved: true,
            color: ColorsStyles.kPrimaryColor,
            barWidth: touchedIndex != -1 ? 4 : 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                final isSelected = index == touchedIndex;
                return FlDotCirclePainter(
                  radius: isSelected ? 6 : 0,
                  color: ColorsStyles.kPrimaryColor,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: ColorsStyles.kPrimaryColor.withOpacity(0.1),
            ),
          ),
          // Last Week Line
          LineChartBarData(
            spots: List.generate(
              widget.orderRateData.weekOrders.length,
              (index) => FlSpot(
                index.toDouble(),
                widget.orderRateData.weekOrders[index].lastWeekOrders,
              ),
            ),
            isCurved: true,
            color: ColorsStyles.kSecondaryColor,
            barWidth: touchedIndex != -1 ? 4 : 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                final isSelected = index == touchedIndex;
                return FlDotCirclePainter(
                  radius: isSelected ? 6 : 0,
                  color: ColorsStyles.kSecondaryColor,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
