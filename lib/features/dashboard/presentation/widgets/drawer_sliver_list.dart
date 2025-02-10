import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/router/app_router.dart';
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
      setState(() {
        selectedIndex = index;
        if (menuItems[selectedIndex].title == "Dashboard") {
          BlocProvider.of<DashboardCubit>(context)
              .changeView(AppRouter.kOrdersView);
        } else if (menuItems[selectedIndex].title == "Food Order") {
          BlocProvider.of<DashboardCubit>(context)
              .changeView(AppRouter.kFoodMenuView);
        } else if (menuItems[selectedIndex].title == "Menu") {
          BlocProvider.of<DashboardCubit>(context)
              .changeView(AppRouter.kBannersView);
        } else if (menuItems[selectedIndex].title == "Banners") {
          BlocProvider.of<DashboardCubit>(context)
              .changeView(AppRouter.kBannersView);
        }
      });
    }
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
