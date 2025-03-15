import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';
import '../../../../core/theming/spacing.dart';
import '../../data/models/banner_model.dart';
import '../widgets/banners_sliver_grid.dart';
import '../widgets/banners_view_header.dart';

class BannersTabletLayout extends StatelessWidget {
  const BannersTabletLayout({
    super.key,
    required this.banners,
  });

  final List<BannerModel> banners;

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      margin: const EdgeInsets.only(left: 10),
      borderRadius: BorderRadius.circular(8),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: BannersViewHeader(),
          ),
          SliverToBoxAdapter(
            child: verticalSpace(10),
          ),
          BannersSliverGrid(
            banners: banners,
          ),
        ],
      ),
    );
  }
}
