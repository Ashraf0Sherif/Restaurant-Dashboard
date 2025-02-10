import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/adaptive_layout.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/desktop_layout.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/mobile_layout.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_drawer.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/tabalet_layout.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer:
          MediaQuery.sizeOf(context).width < 1200 ? const CustomDrawer() : null,
      appBar: MediaQuery.sizeOf(context).width < 1200
          ? AppBar(
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            )
          : null,
      body: AdaptiveLayout(
        mobileLayout: (context) {
          return const MobileLayout();
        },
        tabletLayout: (context) {
          return const TabaletLayout();
        },
        desktopLayout: (context) {
          return const DesktopLayout();
        },
      ),
    );
  }
}
