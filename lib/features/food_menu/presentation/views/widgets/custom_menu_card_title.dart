import 'package:flutter/material.dart';

class CustomMenuCardTitle extends StatelessWidget {
  const CustomMenuCardTitle({
    super.key, required this.title, required this.itemCount,
  });

  final String title;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "$itemCount items",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
