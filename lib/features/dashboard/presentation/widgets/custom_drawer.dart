import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/menu_foodie_header.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/menu_sliver_list.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2C2C2C),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: verticalSpace(30),
          ),
          const SliverToBoxAdapter(
            child: MenuFoodieHeader(),
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
          const MenuSliverList(),
        ],
      ),
    );
  }
}
