import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';

class RevenueHeader extends StatelessWidget {
  const RevenueHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Revenue',
          style: TextStyle(
            fontSize: FontStyles.getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '3,456',
          style: TextStyle(
            fontSize: FontStyles.getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
