import 'package:flutter/material.dart';

final class OrderTimeModel {
  final String title;
  final String dateRange;
  final List<TimeSlot> timeSlots;

  const OrderTimeModel({
    required this.title,
    required this.dateRange,
    required this.timeSlots,
  });
}

final class TimeSlot {
  final String time;
  final double percentage;
  final Color color;

  const TimeSlot({
    required this.time,
    required this.percentage,
    required this.color,
  });
}
