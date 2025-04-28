import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_admin_panel/features/dashboard/logic/order_time_cubit/order_time_cubit.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_order_time_pie_chart.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_header.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_slot.dart';

import '../../../../core/helpers/assets.dart';

class OrderTimeWidget extends StatelessWidget {
  const OrderTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderTimeCubit, OrderTimeState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => Center(
            child: Lottie.asset(AssetsData.kLoadingLottieAnimation,
                animate: true, width: 100),
          ),
          loaded: (orderTimeData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderTimeHeader(
                  orderTimeData: orderTimeData,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child:
                        CustomOrderTimePieChart(orderTimeData: orderTimeData)),
                const SizedBox(height: 20),
                ...orderTimeData.timeSlots.map(
                  (slot) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: OrderTimeSlot(
                      slot: slot,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
