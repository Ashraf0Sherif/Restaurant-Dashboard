import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_rate_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_widget.dart';

class OrderTimeRateSection extends StatelessWidget {
  const OrderTimeRateSection({
    super.key,
  });
  double getResponsiveHeight(BuildContext context) {
    if (MediaQuery.sizeOf(context).width > 1450) {
      return MediaQuery.sizeOf(context).width * 0.25;
    } else if (MediaQuery.sizeOf(context).width > 1000) {
      return MediaQuery.sizeOf(context).width * 0.35;
    } else {
      return MediaQuery.sizeOf(context).width * 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: SizedBox(
                  height: getResponsiveHeight(context),
                  child: const OrderTimeWidget())),
          const Divider(color: Colors.grey),
          Flexible(
              child: SizedBox(
                  height: getResponsiveHeight(context),
                  child: const OrderRateWidget())),
        ],
      ),
    );
  }
}
