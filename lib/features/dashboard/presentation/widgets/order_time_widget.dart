import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
              const Text(
                'Order Time',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
            'From 1-6 Dec, 2020',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 60,
                sections: [
                  PieChartSectionData(
                    value: 40,
                    title: '',
                    color: const Color(0xFF4A5BF6),
                    radius: 40,
                  ),
                  PieChartSectionData(
                    value: 32,
                    title: '',
                    color: const Color(0xFF8E96FF),
                    radius: 40,
                  ),
                  PieChartSectionData(
                    value: 28,
                    title: '',
                    color: const Color(0xFFE2E4FF),
                    radius: 40,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildLegendItem('Afternoon', '40%', const Color(0xFF4A5BF6)),
          const SizedBox(height: 8),
          _buildLegendItem('Evening', '32%', const Color(0xFF8E96FF)),
          const SizedBox(height: 8),
          _buildLegendItem('Morning', '28%', const Color(0xFFE2E4FF)),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String title, String percentage, Color color) {
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
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          percentage,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
