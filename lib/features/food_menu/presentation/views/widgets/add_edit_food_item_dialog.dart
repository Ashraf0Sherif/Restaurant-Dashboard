import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/widgets/stepper_alert_dialog_buttons.dart';

import '../../../data/models/ingredient.dart';
import 'add_additional_ingredients.dart';
import 'add_food_item_general_info.dart';

class AddEditFoodItemDialog extends StatefulWidget {
  const AddEditFoodItemDialog({
    super.key,
  });

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
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode dialogAutovalidateMode = AutovalidateMode.disabled;

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
                      content: AddFoodItemGeneralInfo(
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
                  List<String> imagesUrls = [];
                  for (int i = 0; i < images.length; i++) {
                    Uint8List image = images[i];
                    String fileName =
                        'images/${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
                    UploadTask uploadTask = FirebaseStorage.instance
                        .ref()
                        .child(fileName)
                        .putData(image);
                    TaskSnapshot snapshot = await uploadTask;
                    String downloadURL = await snapshot.ref.getDownloadURL();
                    imagesUrls.add(downloadURL);
                  }
                  await FirebaseFirestore.instance.collection("foodItems").add(
                    {
                      "title": _titleController.text,
                      "description": _descriptionController.text,
                      "deliveryTime": _deliveryTimeController.text,
                      "price": _priceController.text,
                      "images": imagesUrls,
                      "ingredients": ingredients
                          .map((e) => {
                                "name": e.title,
                                "amount": e.price,
                              })
                          .toList(),
                    },
                  );
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
