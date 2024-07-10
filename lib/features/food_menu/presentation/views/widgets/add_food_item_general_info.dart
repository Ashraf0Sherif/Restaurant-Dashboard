import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../../core/utils/widgets/custom_text_form_field.dart';

class AddFoodItemGeneralInfo extends StatefulWidget {
  const AddFoodItemGeneralInfo({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.deliveryTimeController,
    required this.priceController,
    required this.images,
  });

  final TextEditingController titleController,
      descriptionController,
      deliveryTimeController,
      priceController;
  final List<Uint8List> images;

  @override
  State<AddFoodItemGeneralInfo> createState() => _AddFoodItemGeneralInfoState();
}

class _AddFoodItemGeneralInfoState extends State<AddFoodItemGeneralInfo> {
  void selectImages() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files == null) return;
      for (var file in files) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((event) {
          setState(() {
            widget.images.add(reader.result as Uint8List);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Title"),
        CustomTextFormField(
          label: '',
          onChanged: (text) {},
          controller: widget.titleController,
        ),
        const SizedBox(
          width: 5,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Description"),
        CustomTextFormField(
          maxLines: 5,
          minLines: 5,
          label: '',
          onChanged: (text) {},
          controller: widget.descriptionController,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Price"),
                  CustomTextFormField(
                    numbersOnly: true,
                    textInputType: TextInputType.number,
                    label: '',
                    onChanged: (text) {},
                    controller: widget.priceController,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Delivery time (in minutes)"),
                  CustomTextFormField(
                    textInputType: TextInputType.number,
                    numbersOnly: true,
                    label: '',
                    onChanged: (text) {},
                    controller: widget.deliveryTimeController,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        widget.images.isEmpty
            ? Card(
                color: Colors.grey.shade300,
                elevation: 0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Icon(Icons.add_photo_alternate_outlined),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Add images here"),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: selectImages,
                        child: const Text("Click to browse"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: 150,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.images.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == widget.images.length) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade900,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: selectImages,
                          child: const Icon(Icons.add_photo_alternate_outlined),
                        ),
                      );
                    }
                    return Stack(
                      children: [
                        Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.memory(
                              widget.images[index],
                              fit:  BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.images.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return VerticalDivider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    );
                  },
                ),
              ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
