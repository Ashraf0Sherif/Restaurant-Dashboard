import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/navigation_cubit.dart';
import 'package:restaurant_admin_panel/core/di/dependency_injection.dart';
import 'package:restaurant_admin_panel/core/services/firebase/restaurant_firebase.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/repos/dashboard_repo.dart';
import 'package:restaurant_admin_panel/features/dashboard/logic/cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/order_time_rate_section.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/revenue_and_most_ordered_food_section.dart';

class DashboardTabletLayout extends StatelessWidget {
  const DashboardTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => DashboardCubit(getIt())..fetchWeeklyRevenueData(),
      child: CustomScrollView(
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
      ),
    );
  }
}
