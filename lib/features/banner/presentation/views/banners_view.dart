import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/router/app_router.dart';

import '../../../../core/dashboard_cubit/dashboard_cubit.dart';

class BannersView extends StatelessWidget {
  const BannersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Banners"),
              Row(
                children: [
                  SizedBox(
                    width: 400,
                    child: TextField(),
                  ),
                  Spacer(),
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
                      child: const Text("+ Banner",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.47,
                ),
                children: [
                  ...List.generate(12, (index) {
                    return Card(
                      child: Column(
                        children: [
                          Stack(children: [
                            ClipRRect(
                              child: Image.asset('assets/images/banner.jpg'),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue.withOpacity(0.6),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(16),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue.withOpacity(0.6),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    topLeft: Radius.circular(12),
                                  ),
                                ),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit_calendar_rounded,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ]),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  "Banner Title",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  "Banner Description",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  "Start date : 12/12/2022",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                Text(
                                  "End date : 12/12/2022",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
