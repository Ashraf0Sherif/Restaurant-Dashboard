import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/utils/size_config.dart';
import 'package:restaurant_admin_panel/core/utils/widgets/adaptive_layout.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_drawer.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/views/dashboard_mobile_layout.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/views/dashboard_tablet_layout.dart';

import 'core/navigation_cubit/navigation_cubit.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: MediaQuery.sizeOf(context).width < SizeConfig.tablet
              ? const CustomDrawer()
              : null,
          appBar: MediaQuery.sizeOf(context).width < SizeConfig.tablet
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
          body: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
              return AdaptiveLayout(
                mobileLayout: (context) => state is ChangeView
                    ? state.view.mobile
                    : const DashboardMobileLayout(),
                tabletLayout: (context) => state is ChangeView
                    ? state.view.tablet
                    : const DashboardTabletLayout(),
                desktopLayout: (context) => Row(
                  children: [
                    const CustomDrawer(),
                    horizontalSpace(16),
                    Expanded(
                      child: state is ChangeView
                          ? state.view.tablet
                          : const DashboardTabletLayout(),
                    ),
                  ],
                ),
                mobileMaxWidth: state is ChangeView ? state.view.mobileMaxWidth : SizeConfig.mobile,
                tabletMaxWidth: state is ChangeView ? state.view.tabletMaxWidth : SizeConfig.tablet,
              );
            },
          ),
        );
      },
    );
  }
}
