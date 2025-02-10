import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/active_and_inactive_drawer_item.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.data,
    required this.onTap,
  });

  final bool isSelected;
  final IconData icon;
  final String data;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: isSelected
          ? ActiveMenuItem(
              key: const ValueKey('active'),
              icon: icon,
              data: data,
              onTap: onTap,
            )
          : InactiveMenuItem(
              key: const ValueKey('inactive'),
              icon: icon,
              data: data,
              onTap: onTap,
            ),
    );
  }
}
