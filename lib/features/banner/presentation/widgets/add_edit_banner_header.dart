import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';

import '../../../../core/navigation_cubit/navigation_cubit.dart';
import '../../../../core/utils/responsive_views.dart';

class AddEditBannerHeader extends StatelessWidget {
  const AddEditBannerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BackGroundContainer(
        child: Row(
          children: [
            const Text("Add Banner", style: TextStyle(fontSize: 22)),
            const Spacer(),
            TextButton(
              onPressed: () {
                context
                    .read<NavigationCubit>()
                    .changeView(ResponsiveViews.banners);
              },
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  Text("Back", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
