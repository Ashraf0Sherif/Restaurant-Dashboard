import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/dashboard_cubit/dashboard_cubit.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/logic/food_menu_cubit/food_menu_cubit.dart';

import '../../../../../core/utils/widgets/custom_text_form_field.dart';

class AddCategoryAlertDialog extends StatefulWidget {
  const AddCategoryAlertDialog({
    super.key,
  });

  @override
  State<AddCategoryAlertDialog> createState() => _AddCategoryAlertDialogState();
}

class _AddCategoryAlertDialogState extends State<AddCategoryAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final dialogAutovalidateMode = AutovalidateMode.disabled;
  final titleController = TextEditingController();
  Uint8List? imageFile;

  void selectImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      final reader = html.FileReader();
      reader.readAsDataUrl(file!);
      reader.onLoadEnd.listen((event) async {
        setState(() {
          imageFile = base64Decode(reader.result!.toString().split(',')[1]);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add New Category"),
      content: Form(
        child: SizedBox(
          height: 200,
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
                controller: titleController,
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
              BlocProvider.of<FoodMenuCubit>(context).addCategory(
                title: titleController.text,
                imageFile: imageFile,
              );
              Navigator.of(context).pop();
            },
            child: const Text("Add"))
      ],
    );
  }
}
