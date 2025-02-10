import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';

class FoodieHeader extends StatelessWidget {
  const FoodieHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: ColorsStyles.kPrimaryColor,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'F',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FontStyles.getResponsiveFontSize(context, 16),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            horizontalSpace(10),
            Text(
              "FOODIE",
              style: TextStyle(
                fontSize: FontStyles.getResponsiveFontSize(context, 18),
                fontWeight: FontWeight.bold,
                color: ColorsStyles.kPrimaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
