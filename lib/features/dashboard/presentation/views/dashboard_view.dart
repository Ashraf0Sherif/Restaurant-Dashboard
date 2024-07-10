import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/views/widgets/dashboard_widget.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/views/widgets/side_menu.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: const SafeArea(
        child: Row(
          children: [
            Expanded(
              child: SideMenu(),
              flex: 2,
            ),

            Expanded(
              child: DashboardWidget(),
              flex: 12,
            ),
            SizedBox(
              width: 10,
            ),
            // Expanded(
            //   child: SummaryWidget(),
            //   flex: 3,
            // ),
          ],
        ),
      ),
    );
  }
}
