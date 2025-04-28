import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_admin_panel/features/banner/logic/banners_cubit/banners_cubit.dart';
import '../../../../core/helpers/assets.dart';
import 'banners_view_body.dart';

class BannersViewBlocBuilder extends StatefulWidget {
  const BannersViewBlocBuilder({super.key, this.isMobile = false});
  final bool isMobile;
  @override
  State<BannersViewBlocBuilder> createState() => _BannersViewBlocBuilderState();
}

class _BannersViewBlocBuilderState extends State<BannersViewBlocBuilder> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BannersCubit>(context).getBanners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BannersCubit, BannersState>(
        builder: (context, state) {
          if (state is BannersLoading) {
            return Center(
              child: Lottie.asset(AssetsData.kLoadingLottieAnimation,
                  animate: true, width: 100),
            );
          } else if (state is BannersSuccess) {
            return widget.isMobile
                ? BannersViewBody(banners: state.banners, isMobile: true)
                : BannersViewBody(banners: state.banners);
          } else if (state is BannersFailure) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text("Something went wrong!"),
            );
          }
        },
      ),
    );
  }
}
