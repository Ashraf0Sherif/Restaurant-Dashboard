import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dashboard_cubit/dashboard_cubit.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';
import '../../../data/models/banner_model.dart';
import '../../logic/banners_cubit/banners_cubit.dart';

class SuccessBannersView extends StatefulWidget {
  const SuccessBannersView({
    super.key,
    required this.banners,
  });

  final List<BannerModel> banners;

  @override
  State<SuccessBannersView> createState() => _SuccessBannersViewState();
}

class _SuccessBannersViewState extends State<SuccessBannersView> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Banners"),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 400,
                  child: CustomTextFormField(
                    label: 'Search for banner',
                    onChanged: (text) {
                      if (text.isEmpty || text == "") {
                        BlocProvider.of<BannersCubit>(context)
                            .searchBanners('');
                      } else {
                        BlocProvider.of<BannersCubit>(context)
                            .searchBanners(text);
                      }
                    },
                    controller: _searchController,
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    BlocProvider.of<DashboardCubit>(context)
                        .changeView(AppRouter.kAddBannerView);
                  },
                  child: const Text(
                    "+ Banner",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.47,
              ),
              itemCount: widget.banners.length,
              itemBuilder: (context, index) {
                final banner = widget.banners[index];
                return Card(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 230,
                              width: double.infinity,
                              child: Image.network(
                                banner.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue.withOpacity(0.6),
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(16),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<DashboardCubit>(context)
                                      .gotoEditBanner(banner: banner);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.6),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  topLeft: Radius.circular(12),
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<BannersCubit>(context)
                                      .deleteBanner(bannerId: banner.bannerId);
                                },
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                banner.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                banner.description,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                "Start date : ${banner.startDate}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Text(
                                "End date : ${banner.endDate}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
