import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/router/app_router.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/logic/food_menu_cubit/food_menu_cubit.dart';

import '../../../data/models/food_item/food_item.dart';
import 'add_edit_food_item_dialog.dart';

class CategoryFoodItemsView extends StatefulWidget {
  const CategoryFoodItemsView({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<CategoryFoodItemsView> createState() => _CategoryFoodItemsViewState();
}

class _CategoryFoodItemsViewState extends State<CategoryFoodItemsView> {
  List<FoodItem> foodItems = [];
  final List<String> headers = [
    '#',
    'Manage',
    'Item Name',
    'Price',
    'Edit',
    'Delete',
  ];
  int foodItemsIndex = 0;

  @override
  void initState() {
    foodItems = BlocProvider.of<FoodMenuCubit>(context)
        .categories
        .where((element) => element.id == widget.categoryId)
        .first
        .foodItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocBuilder<FoodMenuCubit, FoodMenuState>(builder: (context, state) {
        if (state is FoodMenuLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FoodMenuSuccess) {
          foodItems = state.foodCategories
              .firstWhere((element) => element.id == widget.categoryId)
              .foodItems;
          foodItemsIndex = 0;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text("Manage Food Items",
                          style: TextStyle(fontSize: 22)),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<DashboardCubit>(context)
                              .changeView(AppRouter.kFoodMenuView);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back_ios),
                            Text("Back", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AddEditFoodItemDialog(
                          categoryId: widget.categoryId,
                        );
                      },
                    );
                  },
                  child: const Text("Add Food Item",
                      style: TextStyle(fontSize: 22)),
                ),
                const SizedBox(height: 20),
                Card(
                  child: GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 0,
                      childAspectRatio: 3.5,
                    ),
                    children: [
                      ...List.generate(
                        headers.length,
                        (index) {
                          return buildCell(headers[index],
                              color: Colors.blueGrey.shade500);
                        },
                      ),
                      for (var foodItem in foodItems)
                        ...buildFoodItemRow(
                          foodItem.images[0],
                          foodItem.title,
                          foodItem.price,
                          foodItem.id,
                        ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      }),
    );
  }

  Container buildCell(String title, {Color? color}) {
    return Container(
      color: color ?? Colors.blue.shade300,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  List<Widget> buildFoodItemRow(
      String imageUrl, String name, String price, String foodId) {
    foodItemsIndex++;
    return [
      buildCell(foodItemsIndex.toString()),
      Container(
        padding: const EdgeInsets.all(4.0),
        color: Colors.blue.shade300,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      buildCell(name),
      buildCell(price),
      Container(
        color: Colors.blue.shade300,
        child: Center(
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddEditFoodItemDialog(
                    categoryId: widget.categoryId,
                    foodItem: foodItems[foodItemsIndex - 1],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.edit_note_sharp,
              color: Colors.white,
            ),
          ),
        ),
      ),
      Container(
        color: Colors.blue.shade300,
        child: Center(
          child: IconButton(
            onPressed: () {
              BlocProvider.of<FoodMenuCubit>(context).deleteFoodItem(
                  categoryId: widget.categoryId, foodId: foodId);
              foodItemsIndex = 0;
            },
            icon: const Icon(
              Icons.delete_sharp,
              color: Colors.red,
            ),
          ),
        ),
      ),
    ];
  }
}
