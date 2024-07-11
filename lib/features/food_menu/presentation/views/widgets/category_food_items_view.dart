import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/router/app_router.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/logic/food_menu_cubit/food_menu_cubit.dart';

import '../../../data/models/food_item/food_item.dart';
import '../../../data/models/ingredient/ingredient.dart';
import 'add_edit_food_item_dialog.dart';

class CategoryFoodItemsView extends StatefulWidget {
  const CategoryFoodItemsView(
      {super.key, required this.foodItems, required this.categoryId});

  final List<FoodItem> foodItems;

  final String categoryId;

  @override
  State<CategoryFoodItemsView> createState() => _CategoryFoodItemsViewState();
}

class _CategoryFoodItemsViewState extends State<CategoryFoodItemsView> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          BlocBuilder<FoodMenuCubit, FoodMenuState>(builder: (context, state) {
        if (state is FoodMenuLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("foodCategories")
                  .doc(widget.categoryId)
                  .collection("foodItems")
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  widget.foodItems.clear();
                  foodItemsIndex = 0;
                  for (QueryDocumentSnapshot doc in snapshot.data!.docs) {
                    List<Ingredient> ingredients = [];
                    for (var ingredient in doc['ingredients']) {
                      ingredients.add(Ingredient(
                          price: ingredient['price'],
                          title: ingredient['title']));
                    }
                    List<String> images = [];
                    for (var image in doc['images']) {
                      images.add(image);
                    }
                    widget.foodItems.add(
                      FoodItem(
                          title: doc['title'],
                          description: doc['description'],
                          price: doc['price'],
                          deliverTime: doc['deliveryTime'],
                          images: images,
                          ingredients: ingredients,
                          id: doc.id),
                    );
                  }
                  return Column(
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
                              child: const Text("Back",
                                  style: TextStyle(fontSize: 16)),
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
                        color: Colors.white,
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
                                    color: Colors.grey.shade200);
                              },
                            ),
                            for (var foodItem in widget.foodItems)
                              ...buildFoodItemRow(
                                foodItem.images[0],
                                foodItem.title,
                                foodItem.price,
                                foodItem.id,
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          );
        }
      }),
    );
  }

  Container buildCell(String title, {Color? color}) {
    return Container(
      color: color ?? Colors.transparent,
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
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.fill,
          ),
        ),
      ),
      buildCell(name),
      buildCell(price),
      Center(
        child: IconButton(
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
          icon: const Icon(Icons.edit_note_sharp),
        ),
      ),
      Center(
        child: IconButton(
          onPressed: () {
            BlocProvider.of<FoodMenuCubit>(context)
                .deleteFoodItem(categoryId: widget.categoryId, foodId: foodId);
            foodItemsIndex = 0;
          },
          icon: const Icon(Icons.delete_sharp),
        ),
      ),
    ];
  }
}
