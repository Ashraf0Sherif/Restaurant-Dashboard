import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/custom_drawer.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/tabalet_layout.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: CustomDrawer(),
        ),
        horizontalSpace(16),
        const Expanded(
          flex: 6,
          child: TabaletLayout(),
        ),
      ],
    );
  }
}
