import 'package:flutter/material.dart';

class CategoryItemsView extends StatelessWidget {
  const CategoryItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            width: 300,
            height: 300,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
