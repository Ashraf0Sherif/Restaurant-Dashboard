import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.selectedIndex,
    required this.context,
    required this.icon,
    required this.data,
    required this.index,
    required this.onTap,
  });

  final int selectedIndex;
  final BuildContext context;
  final IconData icon;
  final String data;
  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isSelected = index == selectedIndex;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? ColorsStyles.kPrimaryColor : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 10),
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(
            data,
            style: TextStyle(
              fontSize: FontStyles.getResponsiveFontSize(context, 18),
              color: Colors.white,
            ),
          ),
          trailing: isSelected
              ? Container(
                  width: 3.27,
                  decoration: BoxDecoration(
                    color: ColorsStyles.kSecondaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}