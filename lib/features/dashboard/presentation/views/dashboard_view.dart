import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/dashboard_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_drawer.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomDrawer(),
            ),
            VerticalDivider(
              thickness: 2,
              color: Colors.blueGrey,
              indent: 100,
              endIndent: 100,
            ),
            Expanded(
              flex: 12,
              child: DashboardWidget(),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
