import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';

class OrderRateWidget extends StatelessWidget {
  const OrderRateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order',
                style: TextStyle(
                  fontSize: FontStyles.getResponsiveFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
           Text(
            '2,568',
            style: TextStyle(
              fontSize: FontStyles.getResponsiveFontSize(context, 24),
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.arrow_downward,
                color: Colors.red,
                size: 16,
              ),
               Text(
                '2.1%',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: FontStyles.getResponsiveFontSize(context, 14),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'vs last week',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: FontStyles.getResponsiveFontSize(context, 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Sales from 1-6 Dec, 2020',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: FontStyles.getResponsiveFontSize(context, 14),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SizedBox(
              height: 120,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 20,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.1),
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['01', '02', '03', '04', '05', '06'];
                          if (value < 0 || value >= days.length) {
                            return const Text('');
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              days[value.toInt()],
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: FontStyles.getResponsiveFontSize(context, 12),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 30),
                        FlSpot(1, 25),
                        FlSpot(2, 40),
                        FlSpot(3, 38),
                        FlSpot(4, 32),
                        FlSpot(5, 45),
                      ],
                      isCurved: true,
                      color: ColorsStyles.kPrimaryColor, 
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                    ),
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 35),
                        FlSpot(1, 28),
                        FlSpot(2, 32),
                        FlSpot(3, 42),
                        FlSpot(4, 35),
                        FlSpot(5, 38),
                      ],
                      isCurved: true,
                      color: ColorsStyles.kSecondaryColor, 
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 50,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildLegendItem(context,'Last 6 days', ColorsStyles.kPrimaryColor), 
              const SizedBox(width: 16),
              _buildLegendItem(context,'Last Week', ColorsStyles.kSecondaryColor), 
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context,String title, Color color) {
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
            fontSize: FontStyles.getResponsiveFontSize(context, 12),
          ),
        ),
      ],
    );
  }
}
