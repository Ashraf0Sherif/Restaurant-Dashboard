import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_admin_panel/features/food_menu/logic/food_menu_cubit/food_menu_cubit.dart';

import '../../../../core/utils/widgets/custom_text_form_field.dart';

class AddCategoryAlertDialog extends StatefulWidget {
  const AddCategoryAlertDialog({
    super.key,
  });

  @override
  State<AddCategoryAlertDialog> createState() => _AddCategoryAlertDialogState();
}

class _AddCategoryAlertDialogState extends State<AddCategoryAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode dialogAutovalidateMode = AutovalidateMode.disabled;
  final _titleController = TextEditingController();
  final _arabicTitleController = TextEditingController();
  Uint8List? imageFile;

  void selectImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          imageFile = bytes;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error selecting image: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _arabicTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Add New Category",
      ),
      content: Form(
        key: _formKey,
        autovalidateMode: dialogAutovalidateMode,
        child: SizedBox(
          height: 300,
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: imageFile == null
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: MemoryImage(imageFile!),
                          fit: BoxFit.cover,
                        )),
                child: imageFile != null
                    ? Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.zero,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  imageFile = null;
                                });
                              },
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.red,
                              ),
                            )),
                      )
                    : InkWell(
                        onTap: selectImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 30,
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                label: "Title",
                onChanged: (text) {},
                controller: _titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                label: "Arabic Title",
                onChanged: (text) {},
                controller: _arabicTitleController,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<FoodMenuCubit>(context).addCategory(
                  title: _titleController.text,
                  imageFile: imageFile,
                  arabicTitle: _arabicTitleController.text,
                );
                Navigator.of(context).pop();
              } else {
                setState(() {
                  dialogAutovalidateMode = AutovalidateMode.always;
                });
              }
            },
            child: const Text("Add"))
      ],
    );
  }
}
