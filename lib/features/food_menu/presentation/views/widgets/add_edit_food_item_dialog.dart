import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_admin_panel/core/utils/widgets/show_snack_bar.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/logic/food_menu_cubit/food_menu_cubit.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/widgets/stepper_alert_dialog_buttons.dart';

import '../../../data/models/ingredient/ingredient.dart';
import 'add_additional_ingredients.dart';
import 'add_food_item_general_info.dart';

class AddEditFoodItemDialog extends StatefulWidget {
  AddEditFoodItemDialog({super.key, required this.categoryId, this.foodItem});

  FoodItem? foodItem;
  final String categoryId;

  @override
  State<AddEditFoodItemDialog> createState() => _AddEditFoodItemDialogState();
}

class _AddEditFoodItemDialogState extends State<AddEditFoodItemDialog> {
  List<String> headers = [
    "General",
    "Additional Ingredients",
  ];
  int _currentStep = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<Ingredient> ingredients = [];
  List<Uint8List> images = [];
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode dialogAutovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    if (widget.foodItem != null) {
      _titleController.text = widget.foodItem!.title;
      _descriptionController.text = widget.foodItem!.description;
      _deliveryTimeController.text = widget.foodItem!.deliverTime;
      _priceController.text = widget.foodItem!.price.toString();
      ingredients = widget.foodItem!.ingredients;
      _fetchImages(widget.foodItem!.images);
    } else {
      isLoading = false;
    }
    super.initState();
  }

  Future<void> _fetchImages(List<String> imageUrls) async {
    List<Uint8List> fetchedImages = [];
    for (String url in imageUrls) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        fetchedImages.add(response.bodyBytes);
      }
    }
    setState(() {
      images = fetchedImages;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Form(
        key: _formKey,
        autovalidateMode: dialogAutovalidateMode,
        child: SizedBox(
          height: 680,
          width: 800,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Stepper(
                  elevation: 0,
                  stepIconBuilder: (index, state) {
                    return Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: _currentStep >= index
                              ? Colors.blue.shade900
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                          child: Text(
                        "0${index + 1}",
                        style: const TextStyle(color: Colors.white),
                      )),
                    );
                  },
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                    return const SizedBox();
                  },
                  physics: const ScrollPhysics(),
                  type: StepperType.horizontal,
                  currentStep: _currentStep,
                  steps: [
                    Step(
                      title: const Text("General"),
                      content: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : AddFoodItemGeneralInfo(
                              titleController: _titleController,
                              descriptionController: _descriptionController,
                              deliveryTimeController: _deliveryTimeController,
                              priceController: _priceController,
                              images: images,
                            ),
                    ),
                    Step(
                      title: const Text("Additional Ingredients"),
                      content: AddAdditionalIngredients(
                        ingredients: ingredients,
                      ),
                      isActive: _currentStep == 1,
                    )
                  ],
                ),
              ),
              StepperAlertDialogButtons(
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() {
                      _currentStep -= 1;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
                onStepContinue: () {
                  if (_formKey.currentState!.validate()) {
                    if (images.isEmpty) {
                      showSnackBar(context, message: "Please add images");
                      return;
                    }
                    if (_currentStep < headers.length - 1) {
                      setState(() {
                        _currentStep += 1;
                      });
                    }
                  } else {
                    setState(() {
                      dialogAutovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                firstStep: _currentStep == 0,
                lastStep: _currentStep == headers.length - 1,
                onFinish: () async {
                  if (widget.foodItem != null) {
                    BlocProvider.of<FoodMenuCubit>(context).updateFoodItem(
                      categoryId: widget.categoryId,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      deliveryTime: _deliveryTimeController.text,
                      price: _priceController.text,
                      images: images,
                      ingredients: ingredients,
                      foodId: widget.foodItem!.id,
                    );
                  } else {
                    BlocProvider.of<FoodMenuCubit>(context).addFoodItem(
                      categoryId: widget.categoryId,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      deliveryTime: _deliveryTimeController.text,
                      price: _priceController.text,
                      images: images,
                      ingredients: ingredients,
                    );
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
