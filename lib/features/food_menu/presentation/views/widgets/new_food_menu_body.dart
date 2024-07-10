import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/router/app_router.dart';

class NewFoodMenuBody extends StatelessWidget {
  const NewFoodMenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Text(
                "Food Menu",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Import from CSV",
                        style: TextStyle(fontSize: 16),
                      ))),
              const SizedBox(
                width: 5,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent.shade200,
                  ),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text("Add New Category",
                          style: TextStyle(fontSize: 16)))),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ...List.generate(5, (index) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      topLeft: index % 2 != 0
                          ? Radius.circular(100)
                          : Radius.circular(0),
                      bottomLeft: index % 2 != 0
                          ? Radius.circular(100)
                          : Radius.circular(0),
                      topRight: index % 2 != 0
                          ? Radius.circular(0)
                          : Radius.circular(100),
                      bottomRight: index % 2 != 0
                          ? Radius.circular(0)
                          : Radius.circular(100),
                    ),
                  ),
                  child: Row(
                    textDirection:
                        index % 2 != 0 ? TextDirection.rtl : TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                            topLeft: index % 2 != 0
                                ? Radius.circular(200)
                                : Radius.circular(0),
                            bottomLeft: index % 2 != 0
                                ? Radius.circular(200)
                                : Radius.circular(0),
                            topRight: index % 2 != 0
                                ? Radius.circular(0)
                                : Radius.circular(200),
                            bottomRight: index % 2 != 0
                                ? Radius.circular(0)
                                : Radius.circular(200),
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/turkey-burger-index-64873e8770b34.jpg',
                          ),
                          radius: 120,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.orange),
                            child: const Text(
                              "Burger",
                              style: TextStyle(
                                  fontSize: 34, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 700,
                            height: 180,
                            child: GridView.builder(
                              itemCount: 6,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 1,
                                crossAxisSpacing: 2,
                                childAspectRatio: 6,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                if (index == 5) {
                                  return InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    onTap: () {
                                      BlocProvider.of<DashboardCubit>(context)
                                          .changeView(AppRouter.kCategoryItemsView);
                                    },
                                    child: const Row(
                                      children: [
                                        Text(
                                          "Show Items",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    ),
                                  );
                                } else {
                                  return const Row(
                                    children: [
                                      Text(
                                        "Fruit Salad",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        "\$13",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
