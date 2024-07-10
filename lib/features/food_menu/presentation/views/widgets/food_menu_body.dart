import 'package:flutter/material.dart';

import 'custom_category_card.dart';

class FoodMenuBody extends StatelessWidget {
  const FoodMenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
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
            const SizedBox(
              height: 50,
            ),
            const CustomCategoryCard(
              title: 'Soup Food',
              itemCount: 0,
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomCategoryCard(
              title: 'Chicken',
              itemCount: 0,
            ),
          ],
        ),
      ),
    );
  }
}
