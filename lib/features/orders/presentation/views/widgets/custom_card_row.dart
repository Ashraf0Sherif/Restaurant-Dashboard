import 'package:flutter/material.dart';

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
          color: Colors.blue.shade900.withOpacity(0.6),
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
          color: Colors.purple.shade900.withOpacity(0.6),
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
          color: Colors.orange.shade800.withOpacity(0.6),
          verticalDividerColor: Colors.orange.shade300,
        )),
      ],
    );
  }
}


