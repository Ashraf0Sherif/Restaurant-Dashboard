import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:restaurant_admin_panel/features/banner/presentation/views/banners_view.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/logic/additional_ingredient_cubit/additional_ingredient_cubit.dart';

class IngredientTypeDropDownButton extends StatefulWidget {
  const IngredientTypeDropDownButton({
    super.key,
  });

  @override
  State<IngredientTypeDropDownButton> createState() =>
      _IngredientTypeDropDownButtonState();
}

class _IngredientTypeDropDownButtonState
    extends State<IngredientTypeDropDownButton> {
  final List<String> items = [
    'Main Ingredient',
    'Extra Ingredient',
  ];
  String selectedValue = 'Main Ingredient';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedValue,
      dropdownColor: Colors.grey[900],
      // Dropdown background color
      style: const TextStyle(color: Colors.white),
      // Dropdown text style
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(color: Colors.white), // Item text style
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
          context
              .read<AdditionalIngredientCubit>()
              .emitChangeCurrentType(currentType: selectedValue);
        });
      },
    );
  }
}
