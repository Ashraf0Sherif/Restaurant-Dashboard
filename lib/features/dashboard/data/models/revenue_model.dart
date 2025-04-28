class WeeklyRevenueData {
  final String day;
  final double currentWeekRevenue;
  final double lastWeekRevenue;

  WeeklyRevenueData({
    required this.day,
    required this.currentWeekRevenue,
    required this.lastWeekRevenue,
  });

  factory WeeklyRevenueData.fromFirestore(Map<String, dynamic> data) {
    return WeeklyRevenueData(
      day: data['day'],
      currentWeekRevenue: (data['currentWeekRevenue'] as num?)?.toDouble() ?? 0.0,
      lastWeekRevenue: (data['lastWeekRevenue'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class RevenueModel {
  final List<WeeklyRevenueData> weeklyData;

  RevenueModel({required this.weeklyData});

  factory RevenueModel.fromFirestore(List<Map<String, dynamic>> data) {
    return RevenueModel(
      weeklyData: data.map((e) => WeeklyRevenueData.fromFirestore(e)).toList(),
    );
  }

  double getCurrentWeekRevenue() {
    return weeklyData.map((e) => e.currentWeekRevenue).reduce((a, b) => a + b);
  }
  double getLastWeekRevenue() {
    return weeklyData.map((e) => e.lastWeekRevenue).reduce((a, b) => a + b);
  }
  double getMaxRevenue() {
    return weeklyData
        .map((e) => e.currentWeekRevenue > e.lastWeekRevenue ? e.currentWeekRevenue : e.lastWeekRevenue)
        .reduce((a, b) => a > b ? a : b) + 10;
  }

  double getInterval() {
    return (getMaxRevenue() / 5).ceilToDouble();
  }
}
