import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dashboard_cubit/dashboard_cubit.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/utils/responsive_views.dart';
import '../../../../core/utils/widgets/custom_text_form_field.dart';
import '../../logic/banners_cubit/banners_cubit.dart';

class BannersViewHeader extends StatefulWidget {
  const BannersViewHeader({
    super.key,
  });

  @override
  State<BannersViewHeader> createState() => _BannersViewHeaderState();
}

class _BannersViewHeaderState extends State<BannersViewHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            label: 'Search for banner',
            onChanged: (text) {
              if (text.isEmpty || text == "") {
                context.read<BannersCubit>().searchBanners('');
              } else {
                context.read<BannersCubit>().searchBanners(text);
              }
            },
            controller: _searchController,
          ),
        ),
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: ColorsStyles.kSecondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            context.read<DashboardCubit>().changeView(
                  ResponsiveViews.addEditBannerView(banner: null),
                );
          },
          child: const Text(
            "+ Banner",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
