import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dashboard_cubit/navigation_cubit.dart';
import '../../../../core/utils/responsive_views.dart';

class CategoryFoodItemsBreadCrumb extends StatelessWidget {
  const CategoryFoodItemsBreadCrumb({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () => context
              .read<NavigationCubit>()
              .changeView(ResponsiveViews.foodCategories),
          child: const Text('Food Categories'),
        ),
        const Icon(Icons.chevron_right),
        TextButton(
          onPressed: () {},
          child: const Text('Food List'),
        ),
      ],
    );
  }
}