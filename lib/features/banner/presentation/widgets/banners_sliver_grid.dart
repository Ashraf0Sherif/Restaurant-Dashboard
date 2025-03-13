import 'package:flutter/material.dart';

import '../../data/models/banner_model.dart';
import 'banner_card.dart';

class BannersSliverGrid extends StatelessWidget {
  const BannersSliverGrid(
      {super.key, required this.banners, this.isMobile = false});

  final List<BannerModel> banners;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: banners.length,
      itemBuilder: (context, index) {
        return BannerCard(banner: banners[index]);
      },
    );
  }
}
