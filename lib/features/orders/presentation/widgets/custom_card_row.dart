import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';

import 'custom_info_card.dart';

class CustomCardRow extends StatelessWidget {
  const CustomCardRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomInfoCard(
          title: 'New Orders',
          value: '245',
          percentage: '20%',
          color: Colors.blue.shade900.withValues(alpha: 0.6),
          verticalDividerColor: Colors.blue.shade300,
        )),
        const SizedBox(
          width: 5,
        ),
        Expanded(
            child: CustomInfoCard(
          title: 'Pending Orders',
          value: '245',
          percentage: '20%',
          color: Colors.purple.shade900.withValues(alpha: 0.6),
          verticalDividerColor: Colors.purple.shade300,
        )),
        const SizedBox(
          width: 5,
        ),
        Expanded(
            child: CustomInfoCard(
          title: 'Delivered Orders',
          value: '245',
          percentage: '20%',
          color: ColorsStyles.kPrimaryColor.withValues(alpha: 0.6),
          verticalDividerColor: ColorsStyles.kPrimaryColor,
        )),
      ],
    );
  }
}


