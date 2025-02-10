final class RevenueModel {
  final String totalRevenue;
  final List<MonthlyRevenue> monthlyData;

  const RevenueModel({
    required this.totalRevenue,
    required this.monthlyData,
  });
}

final class MonthlyRevenue {
  final String month;
  final double currentYearRevenue;
  final double previousYearRevenue;

  const MonthlyRevenue({
    required this.month,
    required this.currentYearRevenue,
    required this.previousYearRevenue,
  });
}
