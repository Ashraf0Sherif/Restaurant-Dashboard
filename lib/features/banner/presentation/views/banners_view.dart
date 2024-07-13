import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/features/banner/presentation/logic/banners_cubit/banners_cubit.dart';
import 'package:restaurant_admin_panel/features/banner/presentation/views/widgets/success_banners_view.dart';

class BannersView extends StatefulWidget {
  const BannersView({super.key});

  @override
  State<BannersView> createState() => _BannersViewState();
}

class _BannersViewState extends State<BannersView> {
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BannersSuccess) {
            return SuccessBannersView(banners: state.banners);
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


