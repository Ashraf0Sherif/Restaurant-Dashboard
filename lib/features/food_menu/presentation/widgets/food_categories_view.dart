import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/category/category_model.dart';
import 'package:restaurant_admin_panel/features/food_menu/logic/food_menu_cubit/food_menu_cubit.dart';

import '../../../../constants.dart';
import 'add_category_alert_dialog.dart';
import 'edit_category_alert_dialog.dart';

class FoodCategoriesView extends StatefulWidget {
  const FoodCategoriesView({super.key});

  @override
  State<FoodCategoriesView> createState() => _FoodCategoriesViewState();
}

class _FoodCategoriesViewState extends State<FoodCategoriesView> {
  List<CategoryModel> categories = [];

  @override
  void initState() {
    BlocProvider.of<FoodMenuCubit>(context).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: BlocBuilder<FoodMenuCubit, FoodMenuState>(
        builder: (context, state) {
          if (state is FoodMenuLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FoodMenuSuccess) {
            categories = state.foodCategories;
            return ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    const Text(
                      "Food Menu",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent.shade200,
                        ),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AddCategoryAlertDialog();
                                  });
                            },
                            child: const Text("Add New Category",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)))),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ...List.generate(
                  categories.length >= 5 ? 5 : categories.length,
                  (categoriesIndex) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF2697FF).withOpacity(0.6),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(26),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF21222D),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(200),
                                    bottomRight: Radius.circular(200),
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    categories[categoriesIndex].imageUrl,
                                  ),
                                  radius: 120,
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xFF15131C)),
                                    child: Text(
                                      categories[categoriesIndex].title,
                                      style: const TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 700,
                                    height: 180,
                                    child: GridView.builder(
                                      itemCount: categories[categoriesIndex]
                                              .foodItems
                                              .length +
                                          1,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 1,
                                        crossAxisSpacing: 2,
                                        childAspectRatio: 6,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index ==
                                                categories[categoriesIndex]
                                                    .foodItems
                                                    .length ||
                                            index == 5) {
                                          return InkWell(
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            onTap: () {
                                              BlocProvider.of<DashboardCubit>(
                                                      context)
                                                  .gotoCategoryFoodItems(
                                                      categoryId: categories[
                                                              categoriesIndex]
                                                          .id,
                                                      foodItems: categories[
                                                              categoriesIndex]
                                                          .foodItems);
                                            },
                                            child: const Row(
                                              children: [
                                                Text(
                                                  "Show Items",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(Icons.arrow_forward)
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Row(
                                            children: [
                                              Text(
                                                categories[categoriesIndex]
                                                    .foodItems[index]
                                                    .title,
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 40,
                                              ),
                                              Text(
                                                "\$${categories[categoriesIndex].foodItems[index].price}",
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return EditCategoryAlertDialog(
                                                  category: categories[
                                                      categoriesIndex]);
                                            });
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        BlocProvider.of<FoodMenuCubit>(context)
                                            .deleteCategory(
                                                categoryId:
                                                    categories[categoriesIndex]
                                                        .id);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer()
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
