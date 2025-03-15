import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/navigation_cubit.dart';
import 'package:restaurant_admin_panel/core/utils/responsive_views.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/drawer_item_model.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/drawer_item.dart';

class DrawerSliverList extends StatefulWidget {
  const DrawerSliverList({super.key});

  @override
  State<DrawerSliverList> createState() => _DrawerSliverListState();
}

class _DrawerSliverListState extends State<DrawerSliverList> {
  int selectedIndex = 0;

  final List<DrawerItemModel> menuItems = const [
    DrawerItemModel(
      title: "Dashboard",
      icon: Icons.dashboard,
    ),
    DrawerItemModel(
      title: "Orders",
      icon: Icons.shopify,
    ),
    DrawerItemModel(
      title: "Menu",
      icon: Icons.menu_book,
    ),
    DrawerItemModel(
      title: "Banners",
      icon: Icons.image,
    ),
  ];

  void _handleMenuItemTap(int index) {
    if (selectedIndex != index) {
      setState(
        () {
          selectedIndex = index;
          context.read<NavigationCubit>().selectedIndex = selectedIndex;
          if (menuItems[selectedIndex].title == "Dashboard") {
            context.read<NavigationCubit>().changeView(
                  ResponsiveViews.dashboard
                );
          } else if (menuItems[selectedIndex].title == "Orders") {
            context.read<NavigationCubit>().changeView(
                  ResponsiveViews.orders
                );
          } else if (menuItems[selectedIndex].title == "Menu") {
            context.read<NavigationCubit>().changeView(
                  ResponsiveViews.foodCategories
                );
          } else if (menuItems[selectedIndex].title == "Banners") {
            context.read<NavigationCubit>().changeView(
                  ResponsiveViews.banners
                );
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = context.read<NavigationCubit>().selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(
          menuItems.length,
          (index) => DrawerItem(
            isSelected: selectedIndex == index,
            icon: menuItems[index].icon,
            data: menuItems[index].title,
            onTap: () => _handleMenuItemTap(index),
          ),
        ),
      ),
    );
  }
}
