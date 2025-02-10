import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';

class ThisLastWeek extends StatelessWidget {
  const ThisLastWeek({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildLegendItem(context, 'This Week', ColorsStyles.kPrimaryColor),
        const SizedBox(width: 8),
        _buildLegendItem(context, 'Last Week', ColorsStyles.kSecondaryColor),
      ],
    );
  }

  Widget _buildLegendItem(BuildContext context, String title, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        horizontalSpace(8),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: FontStyles.getResponsiveFontSize(context, 14),
          ),
        ),
      ],
    );
  }
}
