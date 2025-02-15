import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/foodie_header.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/drawer_sliver_list.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF2C2C2C),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: verticalSpace(30),
            ),
            const SliverToBoxAdapter(
              child: FoodieHeader(),
            ),
            SliverToBoxAdapter(
              child: verticalSpace(8),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                color: Colors.grey,
                thickness: 0.3,
              ),
            ),
            SliverToBoxAdapter(
              child: verticalSpace(8),
            ),
            const DrawerSliverList(),
          ],
        ),
      ),
    );
  }
}
