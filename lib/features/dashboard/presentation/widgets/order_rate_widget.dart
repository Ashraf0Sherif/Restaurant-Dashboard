import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/logic/order_rate_cubit/order_rate_cubit.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_order_rate_line_chart.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_rate_header.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/this_last_week.dart';

class OrderRateWidget extends StatelessWidget {
  const OrderRateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderRateCubit, OrderRateState>(
      buildWhen: (previous, current) =>
          current is OrderRateLoaded || current is OrderRateError,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox(),
          error: (message) => Center(child: Text(message)),
          loaded: (orderRateData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderRateHeader(orderRateData: orderRateData),
                const SizedBox(height: 20),
                Expanded(
                  child: CustomOrderRateLineChart(orderRateData: orderRateData),
                ),
                verticalSpace(10),
                const ThisLastWeek(),
              ],
            );
          },
        );
      },
    );
  }
}
