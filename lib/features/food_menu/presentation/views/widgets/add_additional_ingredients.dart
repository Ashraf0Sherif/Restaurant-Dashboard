import 'package:flutter/material.dart';

import '../../../../../core/utils/widgets/custom_text_form_field.dart';
import '../../../data/models/ingredient/ingredient.dart';

class AddAdditionalIngredients extends StatefulWidget {
  const AddAdditionalIngredients({
    super.key,
    required this.ingredients,
  });

  final List<Ingredient> ingredients;

  @override
  State<AddAdditionalIngredients> createState() =>
      _AddAdditionalIngredientsState();
}

class _AddAdditionalIngredientsState extends State<AddAdditionalIngredients> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _dialogFormKey = GlobalKey<FormState>();
  AutovalidateMode dialogAutovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.builder(
          itemCount: widget.ingredients.length + 1,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 4,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == widget.ingredients.length) {
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
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
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                if (_dialogFormKey.currentState!.validate()) {
                                  widget.ingredients.add(
                                    Ingredient(
                                        title: _titleController.text,
                                        price: _priceController.text),
                                  );
                                  _titleController.clear();
                                  _priceController.clear();
                                  Navigator.of(context).pop();
                                  setState(() {});
                                }
                              },
                              child: const Text('Add')),
                        ],
                        content: Form(
                          key: _dialogFormKey,
                          autovalidateMode: dialogAutovalidateMode,
                          child: SizedBox(
                            height: 150,
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomTextFormField(
                                    label: 'Title',
                                    controller: _titleController),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextFormField(
                                    numbersOnly: true,
                                    label: 'Price',
                                    controller: _priceController),
                              ],
                            ),
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
                  child: const Icon(
                    Icons.add,
                    size: 22,
                  ),
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(6)),
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
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.ingredients[index].price,
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
                              bottomRight: Radius.circular(6)),
                        ),
                        child: const Icon(
                          Icons.delete_sharp,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
