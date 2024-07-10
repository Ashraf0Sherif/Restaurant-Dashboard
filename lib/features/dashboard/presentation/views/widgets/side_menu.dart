import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/constants.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/router/app_router.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int selectedIndex = 0;
  List<String> menu = ["Orders", "Food Menu", "Banners"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 80,
      ),
      color: Colors.white,
      child: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {
          return buildMenuEntry(menu[index], index, () {
            setState(
              () {
                selectedIndex = index;
                if(menu[selectedIndex] == "Orders"){
                  BlocProvider.of<DashboardCubit>(context).changeView(AppRouter.kOrdersView);
                }
                else if(menu[selectedIndex] == "Food Menu"){
                  BlocProvider.of<DashboardCubit>(context).changeView(AppRouter.kFoodMenuView);
                }
                else if(menu[selectedIndex] == "Banners"){
                  BlocProvider.of<DashboardCubit>(context).changeView(AppRouter.kBannersView);
                }
              },
            );
          });
        },
      ),
    );
  }

  Widget buildMenuEntry(String data, int index, void Function() onTap) {
    bool isSelected = index == selectedIndex;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? kSelectionColor : Colors.grey,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 13.0,
                vertical: 7,
              ),
              child: Text(
                data,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
