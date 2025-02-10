final class OrderRateModel {
  final String totalOrders;
  final double percentageChange;
  final List<DailyOrder> weekOrders;

  const OrderRateModel({
    required this.totalOrders,
    required this.percentageChange,
    required this.weekOrders,
  });
}

final class DailyOrder {
  final String day;
  final double currentWeekOrders;
  final double lastWeekOrders;

  const DailyOrder({
    required this.day,
    required this.currentWeekOrders,
    required this.lastWeekOrders,
  });
}
