import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';

import '../../../../core/helpers/assets.dart';
import '../../../../core/utils/widgets/custom_text_form_field.dart';
import '../../../../core/utils/widgets/show_snack_bar.dart';
import '../../data/models/banner_model.dart';
import '../../logic/banners_cubit/banners_cubit.dart';

class AddEditBannerForm extends StatefulWidget {
  const AddEditBannerForm({super.key, this.banner});
  final BannerModel? banner;
  @override
  State<AddEditBannerForm> createState() => _AddEditBannerFormState();
}

class _AddEditBannerFormState extends State<AddEditBannerForm> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  late String startDate;
  late String endDate;
  int numberOfDays = 0;
  bool isLoading = true;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? imageFile;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void clear() {
    setState(() {
      selectedStartDate = DateTime.now();
      selectedEndDate = DateTime.now();
      numberOfDays = 0;
      _titleController.clear();
      _descriptionController.clear();
      imageFile = null;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
        startDate = DateFormat('dd/MM/yyyy').format(selectedStartDate);
        _updateNumberOfDays();
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null &&
        picked != selectedEndDate &&
        picked.isAfter(selectedStartDate)) {
      setState(() {
        selectedEndDate = picked;
        endDate = DateFormat('dd/MM/yyyy').format(selectedEndDate);
        _updateNumberOfDays();
      });
    }
  }

  void _updateNumberOfDays() {
    setState(() {
      numberOfDays = selectedEndDate.difference(selectedStartDate).inDays;
    });
  }

  void selectImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          imageFile = bytes;
        });
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, message: 'Error selecting image: $e');
      }
    }
  }

  Future<void> _fetchImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        setState(() {
          imageFile = response.bodyBytes;
          isLoading = false;
        });
      } else {
        showSnackBar(context, message: 'Failed to load image');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      showSnackBar(context, message: 'Error loading image: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startDate = DateFormat('dd/MM/yyyy').format(selectedStartDate);
    endDate = DateFormat('dd/MM/yyyy').format(selectedEndDate);

    if (widget.banner != null) {
      _titleController.text = widget.banner!.title;
      _descriptionController.text = widget.banner!.description;
      startDate = widget.banner!.startDate;
      endDate = widget.banner!.endDate;

      // Parse dates to update number of days
      try {
        selectedStartDate = DateFormat('dd/MM/yyyy').parse(startDate);
        selectedEndDate = DateFormat('dd/MM/yyyy').parse(endDate);
        _updateNumberOfDays();
      } catch (e) {
        // Handle date parsing error
      }

      if (widget.banner!.image.isNotEmpty) {
        _fetchImage(widget.banner!.image);
      } else {
        isLoading = false;
      }
    } else {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      width: double.infinity,
      child: isLoading
          ?  Center(child: Lottie.asset(AssetsData.kLoadingLottieAnimation,
                  animate: true, width: 100))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            color: const Color(0xFF2C2C2C),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Column(
                          children: [
                            const Text(
                              "Banner Image",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 15),
                            imageFile == null
                                ? Column(
                                    children: [
                                      Icon(
                                        Icons.image_outlined,
                                        size: 80,
                                        color: Colors.grey.shade400,
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black12,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: selectImage,
                                        icon: const Icon(Icons.upload),
                                        label: const Text(
                                          "Upload Image",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: 300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.memory(imageFile!),
                                            ),
                                          ),
                                          Positioned(
                                            top: -10,
                                            right: -10,
                                            child: Material(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onTap: () {
                                                  setState(() {
                                                    imageFile = null;
                                                  });
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      TextButton.icon(
                                        onPressed: selectImage,
                                        icon: const Icon(Icons.refresh),
                                        label: const Text("Change Image"),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Form fields
                      CustomTextFormField(
                        label: 'Banner Title',
                        hintText: 'Enter a descriptive title',
                        onChanged: (onChanged) {},
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      CustomTextFormField(
                        minLines: 3,
                        maxLines: 5,
                        label: 'Banner Description',
                        hintText: "Enter a detailed description",
                        onChanged: (onChanged) {},
                        controller: _descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Date selection section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C2C2C),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Banner Duration",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () => _selectStartDate(context),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2C2C2C),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(Icons.calendar_today,
                                                  size: 16),
                                              SizedBox(width: 8),
                                              Text(
                                                "Start Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            startDate,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => _selectEndDate(context),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2C2C2C),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(Icons.calendar_today,
                                                  size: 16),
                                              SizedBox(width: 8),
                                              Text(
                                                "End Date",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            endDate,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.lightBlueAccent
                                        .withOpacity(0.3)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.date_range,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Duration: $numberOfDays days",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey.shade700,
                              side: BorderSide(color: Colors.grey.shade400),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: clear,
                            icon: const Icon(Icons.refresh),
                            label: const Text(
                              "Reset Form",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black12,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (imageFile == null) {
                                  showSnackBar(context,
                                      message: "Please select an image");
                                  return;
                                }

                                if (selectedStartDate
                                    .isAfter(selectedEndDate)) {
                                  showSnackBar(context,
                                      message:
                                          "Start date cannot be after end date");
                                  return;
                                }

                                if (widget.banner != null) {
                                  context.read<BannersCubit>().updateBanner(
                                      banner: BannerModel(
                                          bannerId: widget.banner!.bannerId,
                                          title: _titleController.text,
                                          description:
                                              _descriptionController.text,
                                          image: '',
                                          startDate: startDate,
                                          endDate: endDate),
                                      imageFile: imageFile!);
                                } else {
                                  BlocProvider.of<BannersCubit>(context)
                                      .addBanner(
                                          banner: BannerModel(
                                              bannerId: '',
                                              title: _titleController.text,
                                              description:
                                                  _descriptionController.text,
                                              image: '',
                                              startDate: startDate,
                                              endDate: endDate),
                                          imageFile: imageFile!);
                                }
                              } else {
                                setState(() {
                                  autovalidateMode = AutovalidateMode.always;
                                });
                              }
                            },
                            icon: Icon(
                              widget.banner != null ? Icons.update : Icons.add,
                            ),
                            label: Text(
                              widget.banner != null
                                  ? "Update Banner"
                                  : "Add Banner",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
