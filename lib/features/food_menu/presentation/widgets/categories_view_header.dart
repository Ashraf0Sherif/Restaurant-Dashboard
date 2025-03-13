import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';

class CategoriesViewHeader extends StatelessWidget {
  const CategoriesViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('Foodie'),
        ),
        const Icon(Icons.chevron_right),
        TextButton(
          onPressed: () {},
          child: const Text('Food Categories'),
        ),
      ],
    );
  }
}
