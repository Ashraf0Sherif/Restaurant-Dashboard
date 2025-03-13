import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/features/food_menu/logic/food_menu_cubit/food_menu_cubit.dart';

class CategoriesDropDownButton extends StatefulWidget {
  const CategoriesDropDownButton({super.key, required this.categoryId});
  final String categoryId;
  @override
  State<CategoriesDropDownButton> createState() =>
      _CategoriesDropDownButtonState();
}

class _CategoriesDropDownButtonState extends State<CategoriesDropDownButton> {
  String? _selectedCategory;
  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.categoryId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: BlocBuilder<FoodMenuCubit, FoodMenuState>(
        builder: (context, state) {
          final categories = context.read<FoodMenuCubit>().categories;
          return DropdownButton<String>(
            value: _selectedCategory,
            isExpanded: true,
            underline: const SizedBox(),
            hint: const Text('Select Category'),
            items: categories.map((category) {
              return DropdownMenuItem(
                value: category.id,
                child: Text(category.title),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
          );
        },
      ),
    );
  }
}
