import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/revenue_model.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_revenue_bar_chart.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_header.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/this_last_week.dart';

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
  double getResponsiveHeight(BuildContext context) {
    if (MediaQuery.sizeOf(context).width > 1450) {
      return MediaQuery.sizeOf(context).width * 0.25;
    } else if (MediaQuery.sizeOf(context).width > 1000) {
      return MediaQuery.sizeOf(context).width * 0.35;
    } else {
      return MediaQuery.sizeOf(context).width * 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const RevenueHeader(),
          verticalSpace(10),
          Flexible(
            child: SizedBox(
                height: getResponsiveHeight(context),
                child: CustomRevenueBarChart(revenueData: revenueData)),
          ),
          verticalSpace(10),
          const ThisLastWeek(),
        ],
      ),
    );
  }
}
