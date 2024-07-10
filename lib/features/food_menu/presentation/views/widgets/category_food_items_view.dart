import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/core/router/app_router.dart';

import 'add_edit_food_item_dialog.dart';

class CategoryFoodItemsView extends StatefulWidget {
  const CategoryFoodItemsView({super.key});

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

  final List<Map<String, String>> foodItems = [
    {
      'index': '1',
      'imageUrl': 'assets/images/turkey-burger-index-64873e8770b34.jpg',
      'name': 'Burger',
      'price': '\$ 45',
    },
    {
      'index': '2',
      'imageUrl': 'assets/images/turkey-burger-index-64873e8770b34.jpg',
      'name': 'Pizza',
      'price': '\$ 60',
    },
    {
      'index': '3',
      'imageUrl': 'assets/images/turkey-burger-index-64873e8770b34.jpg',
      'name': 'Pasta',
      'price': '\$ 35',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                    child: Text("Back", style: TextStyle(fontSize: 16)),
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
                    return const AddEditFoodItemDialog();
                  },
                );
              },
              child: Text("Add Food Item", style: TextStyle(fontSize: 22)),
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  for (var foodItem in foodItems)
                    ...buildFoodItemRow(
                      foodItem['index']!,
                      foodItem['imageUrl']!,
                      foodItem['name']!,
                      foodItem['price']!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildCell(String title, {Color? color}) {
    return Container(
      color: color ?? Colors.transparent,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  List<Widget> buildFoodItemRow(
      String index, String imageUrl, String name, String price) {
    return [
      buildCell(index),
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(imageUrl),
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
                return const AddEditFoodItemDialog();
              },
            );
          },
          icon: const Icon(Icons.edit_note_sharp),
        ),
      ),
      Center(
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_sharp),
        ),
      ),
    ];
  }
}
