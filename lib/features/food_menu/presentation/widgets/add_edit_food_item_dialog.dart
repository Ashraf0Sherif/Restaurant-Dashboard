import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_admin_panel/core/utils/widgets/show_snack_bar.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/food_item/food_item.dart';
import 'package:restaurant_admin_panel/features/food_menu/data/models/ingredient/extra_ingredient.dart';
import 'package:restaurant_admin_panel/features/food_menu/logic/additional_ingredient_cubit/additional_ingredient_cubit.dart';
import 'package:restaurant_admin_panel/features/food_menu/logic/food_menu_cubit/food_menu_cubit.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/widgets/stepper_alert_dialog_buttons.dart';

import '../../data/models/ingredient/ingredient.dart';
import 'add_additional_ingredients.dart';
import 'add_food_item_general_info.dart';

class AddEditFoodItemDialog extends StatefulWidget {
  const AddEditFoodItemDialog(
      {super.key, required this.categoryId, this.foodItem});

  final FoodItem? foodItem;
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
  final TextEditingController _arabicTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _arabicDescriptionController =
      TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<Ingredient> ingredients = [];
  List<ExtraIngredient> extraIngredients = [];
  List<Uint8List> images = [];
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode dialogAutovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    if (widget.foodItem != null) {
      _titleController.text = widget.foodItem!.title;
      _descriptionController.text = widget.foodItem!.description;
      _arabicTitleController.text = widget.foodItem!.arabicTitle;
      _arabicDescriptionController.text = widget.foodItem!.arabicDescription;
      _deliveryTimeController.text = widget.foodItem!.deliverTime;
      _priceController.text = widget.foodItem!.price.toString();
      ingredients = widget.foodItem!.ingredients;
      extraIngredients = widget.foodItem!.extraIngredients;
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
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _deliveryTimeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                              arabicTitleController: _arabicTitleController,
                              arabicDescriptionController:
                                  _arabicDescriptionController,
                            ),
                    ),
                    Step(
                      title: const Text("Additional Ingredients"),
                      content: BlocProvider(
                        create: (context) => AdditionalIngredientCubit(),
                        child: AddAdditionalIngredients(
                          ingredients: ingredients,
                          extraIngredients: extraIngredients,
                        ),
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
                    widget.foodItem!.title = _titleController.text;
                    widget.foodItem!.description = _descriptionController.text;
                    widget.foodItem!.deliverTime = _deliveryTimeController.text;
                    widget.foodItem!.price = _priceController.text;
                    widget.foodItem!.ingredients = ingredients;
                    BlocProvider.of<FoodMenuCubit>(context).updateFoodItem(
                        categoryId: widget.categoryId,
                        foodItem: widget.foodItem!,
                        images: images);
                  } else {
                    BlocProvider.of<FoodMenuCubit>(context).addFoodItem(
                      categoryId: widget.categoryId,
                      foodItem: FoodItem(
                          id: '',
                          title: _titleController.text,
                          description: _descriptionController.text,
                          price: _priceController.text,
                          deliverTime: _deliveryTimeController.text,
                          images: [],
                          ingredients: ingredients,
                          extraIngredients: extraIngredients,
                          arabicTitle: _arabicTitleController.text,
                          arabicDescription: _arabicDescriptionController.text),
                      images: images,
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
