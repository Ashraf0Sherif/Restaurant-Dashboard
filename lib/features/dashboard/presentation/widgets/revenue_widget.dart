import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/revenue_model.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_revenue_bar_chart.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_header.dart';

class RevenueWidget extends StatelessWidget {
  final RevenueModel revenueData;

  const RevenueWidget({
    super.key,
    this.revenueData = const RevenueModel(
      totalRevenue: '3,456',
      monthlyData: [
        MonthlyRevenue(
            month: '01', currentYearRevenue: 40, previousYearRevenue: 30),
        MonthlyRevenue(
            month: '02', currentYearRevenue: 60, previousYearRevenue: 50),
        MonthlyRevenue(
            month: '03', currentYearRevenue: 45, previousYearRevenue: 35),
        MonthlyRevenue(
            month: '04', currentYearRevenue: 35, previousYearRevenue: 45),
        MonthlyRevenue(
            month: '05', currentYearRevenue: 65, previousYearRevenue: 40),
        MonthlyRevenue(
            month: '06', currentYearRevenue: 75, previousYearRevenue: 35),
        MonthlyRevenue(
            month: '07', currentYearRevenue: 50, previousYearRevenue: 40),
        MonthlyRevenue(
            month: '08', currentYearRevenue: 45, previousYearRevenue: 50),
        MonthlyRevenue(
            month: '09', currentYearRevenue: 50, previousYearRevenue: 40),
        MonthlyRevenue(
            month: '10', currentYearRevenue: 40, previousYearRevenue: 30),
        MonthlyRevenue(
            month: '11', currentYearRevenue: 60, previousYearRevenue: 40),
        MonthlyRevenue(
            month: '12', currentYearRevenue: 70, previousYearRevenue: 45),
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const RevenueHeader(),
          const SizedBox(height: 10),
          Expanded(
            child: CustomRevenueBarChart(revenueData: revenueData),
          ),
        ],
      ),
    );
  }
}
