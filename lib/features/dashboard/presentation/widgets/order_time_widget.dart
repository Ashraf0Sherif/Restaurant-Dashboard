import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';

class OrderTimeWidget extends StatelessWidget {
  const OrderTimeWidget({super.key});

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
                'Order Time',
                style: TextStyle(
                  fontSize: FontStyles.getResponsiveFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            'From 1-6 Dec, 2020',
            style: TextStyle(
              fontSize: FontStyles.getResponsiveFontSize(context, 14),
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 65,
                sections: [
                  PieChartSectionData(
                    value: 40,
                    title: '',
                    color: ColorsStyles.kPrimaryColor,
                    radius: 40,
                  ),
                  PieChartSectionData(
                    value: 32,
                    title: '',
                    color: ColorsStyles.kSecondaryColor,
                    radius: 40,
                  ),
                  PieChartSectionData(
                    value: 28,
                    title: '',
                    color: ColorsStyles.kPassiveColor,
                    radius: 40,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildLegendItem(
              context, 'Afternoon', '40%', const Color(0xFF4A5BF6)),
          const SizedBox(height: 8),
          _buildLegendItem(context, 'Evening', '32%', const Color(0xFF8E96FF)),
          const SizedBox(height: 8),
          _buildLegendItem(context, 'Morning', '28%', const Color(0xFFE2E4FF)),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
      BuildContext context, String title, String percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: FontStyles.getResponsiveFontSize(context, 14),
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          percentage,
          style: TextStyle(
            fontSize: FontStyles.getResponsiveFontSize(context, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
