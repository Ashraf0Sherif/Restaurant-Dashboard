import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/di/dependency_injection.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/logic/most_ordered_food_cubit/most_ordered_food_cubit.dart';
import 'package:restaurant_admin_panel/features/dashboard/logic/order_rate_cubit/order_rate_cubit.dart';
import 'package:restaurant_admin_panel/features/dashboard/logic/order_time_cubit/order_time_cubit.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_rate_section.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_and_most_ordered_food_section.dart';

import '../../logic/revenue_cubit/revenue_cubit.dart';

class DashboardTabletLayout extends StatelessWidget {
  const DashboardTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RevenueCubit>(
          create: (context) => RevenueCubit(getIt())..fetchWeeklyRevenueData(),
        ),
        BlocProvider<MostOrderedFoodCubit>(
          create: (context) =>
              MostOrderedFoodCubit(getIt())..fetchMostOrderedFood(),
        ),
        BlocProvider<OrderTimeCubit>(
          create: (context) => OrderTimeCubit(getIt())..fetchOrderTime(),
        ),
        BlocProvider<OrderRateCubit>(
          create: (context) => OrderRateCubit(getIt())..fetchOrderRate(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final revenueState = context.watch<RevenueCubit>().state;
          final mostOrderedFoodState =
              context.watch<MostOrderedFoodCubit>().state;
          final orderTimeState = context.watch<OrderTimeCubit>().state;
          final orderRateState = context.watch<OrderRateCubit>().state;
          if (revenueState is RevenueLoaded ||
              mostOrderedFoodState is MostOrderedFoodLoaded ||
              orderTimeState is OrderTimeLoaded ||
              orderRateState is OrderRateLoaded) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                          flex: 2, child: RevenueAndMostOrderFoodSection()),
                      horizontalSpace(16),
                      const Expanded(child: OrderTimeRateSection()),
                      horizontalSpace(16),
                    ],
                  ),
                )
              ],
            );
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
