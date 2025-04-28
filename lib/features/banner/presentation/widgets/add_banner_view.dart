import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';
import 'package:restaurant_admin_panel/core/utils/widgets/show_snack_bar.dart';
import 'package:restaurant_admin_panel/features/banner/data/models/banner_model.dart';
import 'package:restaurant_admin_panel/features/banner/logic/banners_cubit/banners_cubit.dart';

import '../../../../core/helpers/assets.dart';
import 'add_edit_banner_form.dart';
import 'add_edit_banner_header.dart';

class AddEditBannerView extends StatefulWidget {
  const AddEditBannerView({super.key, this.banner});

  final BannerModel? banner;

  @override
  State<AddEditBannerView> createState() => _AddEditBannerViewState();
}

class _AddEditBannerViewState extends State<AddEditBannerView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: AddEditBannerHeader(),
            ),
            SliverToBoxAdapter(
              child: verticalSpace(30),
            ),
            SliverToBoxAdapter(
              child: BlocConsumer<BannersCubit, BannersState>(
                builder: (context, state) {
                  if (state is BannersLoading) {
                    return  Center(
                      child: Lottie.asset(AssetsData.kLoadingLottieAnimation,
                  animate: true, width: 100),
                    );
                  } else {
                    return AddEditBannerForm(
                      banner: widget.banner,
                    );
                  }
                },
                listener: (BuildContext context, BannersState state) {
                  if (state is BannersFailure) {
                  } else if (state is BannersSuccess) {
                    showSnackBar(context,
                        message: widget.banner != null
                            ? "Banner updated successfully"
                            : "Banner added successfully");
                  }
                },
              ),
            ),
          ],
        ));
  }
}
