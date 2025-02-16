import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/utils/widgets/adaptive_layout.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_drawer.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/mobile_layout.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/tabalet_layout.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          key: MediaQuery.sizeOf(context).width < 1200 ? _scaffoldKey : null,
          drawer: MediaQuery.sizeOf(context).width < 1200
              ? const CustomDrawer()
              : null,
          appBar: MediaQuery.sizeOf(context).width < 1200
              ? AppBar(
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                )
              : null,
          body: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return AdaptiveLayout(
                mobileLayout: (context) => state is ChangeView
                    ? state.widget.mobile
                    : const MobileLayout(),
                tabletLayout: (context) => state is ChangeView
                    ? state.widget.tablet
                    : const TabaletLayout(),
                desktopLayout: (context) => Row(
                  children: [
                    const CustomDrawer(),
                    horizontalSpace(16),
                    Expanded(
                      child: state is ChangeView
                          ? state.widget.tablet
                          : const TabaletLayout(),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
