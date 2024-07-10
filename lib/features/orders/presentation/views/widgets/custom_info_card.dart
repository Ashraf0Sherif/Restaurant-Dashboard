import 'package:flutter/material.dart';

class CustomInfoCard extends StatelessWidget {
  const CustomInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.color,
    required this.verticalDividerColor,
  });

  final String title, value, percentage;
  final Color color, verticalDividerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                value,
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 10,
                height: 30,
                child: VerticalDivider(
                  color: verticalDividerColor,
                  width: 5,
                  thickness: 2,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Impressions - ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                percentage,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
