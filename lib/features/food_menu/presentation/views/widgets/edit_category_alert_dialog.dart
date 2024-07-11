import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/custom_text_form_field.dart';
import '../../../data/models/category/category_model.dart';
import '../../logic/food_menu_cubit/food_menu_cubit.dart';

class EditCategoryAlertDialog extends StatefulWidget {
  const EditCategoryAlertDialog({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  State<EditCategoryAlertDialog> createState() =>
      _EditCategoryAlertDialogState();
}

class _EditCategoryAlertDialogState extends State<EditCategoryAlertDialog> {
  Uint8List? imageFile;
  final TextEditingController _titleController = TextEditingController();

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
  void initState() {
    _titleController.text = widget.category.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Category ${widget.category.title}"),
      content: Form(
        child: SizedBox(
          height: 200,
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageFile == null
                          ? NetworkImage(widget.category.imageUrl)
                          : MemoryImage(imageFile!),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.zero,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
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
              BlocProvider.of<FoodMenuCubit>(context).updateCategory(
                  categoryId: widget.category.id,
                  title: _titleController.text,
                  imageFile: imageFile);
              Navigator.of(context).pop();
            },
            child: const Text("Edit"))
      ],
    );
  }
}