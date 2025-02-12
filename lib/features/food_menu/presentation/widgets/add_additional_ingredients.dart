import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/ingredient/extra_ingredient.dart';
import 'package:restaurant_admin_panel/features/food_menu/logic/additional_ingredient_cubit/additional_ingredient_cubit.dart';

import '../../data/models/ingredient/ingredient.dart';
import 'add_additional_ingredient_form.dart';

class AddAdditionalIngredients extends StatefulWidget {
  const AddAdditionalIngredients({
    super.key,
    required this.ingredients,
    required this.extraIngredients,
  });

  final List<Ingredient> ingredients;
  final List<ExtraIngredient> extraIngredients;

  @override
  State<AddAdditionalIngredients> createState() =>
      _AddAdditionalIngredientsState();
}

class _AddAdditionalIngredientsState extends State<AddAdditionalIngredients> {
  final _titleController = TextEditingController();
  final _arabicTitleController = TextEditingController();
  final _priceController = TextEditingController();
  final _dialogFormKey = GlobalKey<FormState>();
  AutovalidateMode dialogAutovalidateMode = AutovalidateMode.disabled;
  String currentType = 'Main Ingredient';

  @override
  void initState() {
    super.initState();
    print(widget.extraIngredients);
    print(widget.ingredients);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _arabicTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalItems =
        widget.ingredients.length + widget.extraIngredients.length + 1;
    return Stack(
      children: [
        GridView.builder(
          itemCount: totalItems,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 3.3,
          ),
          itemBuilder: (BuildContext context, int index) {
            // Add new ingredient/extra ingredient button
            if (index == totalItems - 1) {
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => AdditionalIngredientCubit(),
                        child: AlertDialog(
                          title: const Text('Add Ingredient'),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            BlocListener<AdditionalIngredientCubit,
                                AdditionalIngredientState>(
                              listener: (context, state) {
                                if (state
                                    is AdditionalIngredientCurrentTypeChanged) {
                                  currentType = state.currentType;
                                }
                              },
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onPressed: () {
                                  if (_dialogFormKey.currentState!.validate()) {
                                    if (currentType == 'Extra Ingredient') {
                                      widget.extraIngredients.add(
                                        ExtraIngredient(
                                          title: _titleController.text,
                                          price: _priceController.text,
                                          arabicTitle:
                                              _arabicTitleController.text,
                                        ),
                                      );
                                    } else {
                                      widget.ingredients.add(
                                        Ingredient(
                                          title: _titleController.text,
                                          arabicTitle:
                                              _arabicTitleController.text,
                                        ),
                                      );
                                    }
                                    _titleController.clear();
                                    _priceController.clear();
                                    _arabicTitleController.clear();
                                    setState(() {});
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text('Add'),
                              ),
                            ),
                          ],
                          content: AddAdditionalIngredientForm(
                            dialogFormKey: _dialogFormKey,
                            dialogAutovalidateMode: dialogAutovalidateMode,
                            titleController: _titleController,
                            priceController: _priceController,
                            arabicTitleController: _arabicTitleController,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade500,
                      borderRadius: BorderRadius.circular(6)),
                  child: const Icon(Icons.add, size: 22),
                ),
              );
            }

            // Determine if it's a main ingredient or extra ingredient
            if (index < widget.ingredients.length) {
              // Main Ingredients
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.ingredients[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: InkWell(
                        onTap: () {
                          widget.ingredients.removeAt(index);
                          setState(() {});
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                          child: const Icon(Icons.delete_sharp, size: 22),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Extra Ingredients
              final extraIndex = index - widget.ingredients.length;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade800,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.extraIngredients[extraIndex].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            '\$${widget.extraIngredients[extraIndex].price}',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: InkWell(
                        onTap: () {
                          widget.extraIngredients.removeAt(extraIndex);
                          setState(() {});
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                          child: const Icon(Icons.delete_sharp, size: 22),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
