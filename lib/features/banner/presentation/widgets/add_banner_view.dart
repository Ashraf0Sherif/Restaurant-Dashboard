import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/utils/widgets/show_snack_bar.dart';
import 'package:restaurant_admin_panel/features/banner/data/models/banner_model.dart';
import 'package:restaurant_admin_panel/features/banner/logic/banners_cubit/banners_cubit.dart';

import '../../../../core/dashboard_cubit/dashboard_cubit.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/widgets/custom_text_form_field.dart';

class AddEditBannerView extends StatefulWidget {
  const AddEditBannerView({super.key, this.banner});

  final BannerModel? banner;

  @override
  State<AddEditBannerView> createState() => _AddEditBannerViewState();
}

class _AddEditBannerViewState extends State<AddEditBannerView> {
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
    selectedStartDate = DateTime.now();
    selectedEndDate = DateTime.now();
    numberOfDays = 0;
    _titleController.clear();
    _descriptionController.clear();
    imageFile = null;
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
    if (picked != null && picked != selectedEndDate) {
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

  Future<void> _fetchImage(String imageUrl) async {
    Uint8List fetchedImageFile = Uint8List(0);
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      fetchedImageFile = response.bodyBytes;
    }
    setState(() {
      imageFile = fetchedImageFile;
      isLoading = false;
    });
  }
  @override
  void initState() {
    startDate = DateFormat('dd/MM/yyyy').format(selectedStartDate);
    endDate = DateFormat('dd/MM/yyyy').format(selectedEndDate);
    if (widget.banner != null) {
      _titleController.text = widget.banner!.title;
      _descriptionController.text = widget.banner!.description;
      startDate = widget.banner!.startDate;
      endDate = widget.banner!.endDate;
      _fetchImage(widget.banner!.image);
    } else {
      isLoading = false;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text("Add Banner", style: TextStyle(fontSize: 22)),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<DashboardCubit>(context)
                              .changeView(AppRouter.kBannersView);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back_ios),
                            Text("Back", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50), // Add some space before the form
                Row(
                  children: [
                    const SizedBox(
                      width: 200,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocConsumer<BannersCubit, BannersState>(
                            builder: (context, state) {
                              if (state is BannersLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Card(
                                  color: ColorsStyles.kCustomRedColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Form(
                                      key: _formKey,
                                      autovalidateMode: autovalidateMode,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const Spacer(),
                                              Expanded(
                                                child: CustomTextFormField(
                                                    label: 'Title',
                                                    onChanged: (onChanged) {},
                                                    controller:
                                                        _titleController),
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              const Spacer(),
                                              Expanded(
                                                child: CustomTextFormField(
                                                  minLines: 5,
                                                  maxLines: 5,
                                                  label: 'Description',
                                                  onChanged: (onChanged) {},
                                                  hintText: "Enter description",
                                                  controller:
                                                      _descriptionController,
                                                ),
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          imageFile == null
                                              ? SizedBox(
                                                  width: 300,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor: Colors
                                                            .lightBlueAccent,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                        ),
                                                      ),
                                                      onPressed: selectImage,
                                                      child:  Text(
                                                          "Choose Banner Image",)),
                                                )
                                              : SizedBox(
                                                  width: 300,
                                                  child: Stack(
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.memory(
                                                              imageFile!)),
                                                      Positioned(
                                                        top: 0,
                                                        right: 0,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              imageFile = null;
                                                            });
                                                          },
                                                          icon: const Icon(
                                                            Icons.close,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ListTile(
                                                  onTap: () {
                                                    _selectStartDate(context);
                                                  },
                                                  title: const Text(
                                                    "Start",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  subtitle: Text(
                                                    startDate,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  trailing: const Icon(
                                                      Icons.date_range),
                                                ),
                                              ),
                                              const VerticalDivider(),
                                              Expanded(
                                                child: ListTile(
                                                  title: const Text(
                                                    "Number of days",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  subtitle: Text(
                                                    numberOfDays.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              const VerticalDivider(),
                                              Expanded(
                                                child: ListTile(
                                                  onTap: () {
                                                    _selectEndDate(context);
                                                  },
                                                  title: const Text(
                                                    "End",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  subtitle: Text(
                                                    endDate,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  trailing: const Icon(
                                                      Icons.date_range),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.lightBlueAccent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                              ),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (imageFile == null) {
                                                    showSnackBar(context,
                                                        message:
                                                            "Please select image");
                                                    return;
                                                  }
                                                  if (selectedStartDate.isAfter(
                                                      selectedEndDate)) {
                                                    showSnackBar(context,
                                                        message:
                                                            "Start date cannot be after end date");
                                                    return;
                                                  }
                                                  if (widget.banner != null) {
                                                    widget.banner!.title =
                                                        _titleController.text;
                                                    widget.banner!.description =
                                                        _descriptionController
                                                            .text;
                                                    widget.banner!.startDate =
                                                        startDate;
                                                    widget.banner!.endDate =
                                                        endDate;
                                                    BlocProvider.of<
                                                                BannersCubit>(
                                                            context)
                                                        .updateBanner(
                                                            banner: BannerModel(
                                                                bannerId: widget
                                                                    .banner!
                                                                    .bannerId,
                                                                title:
                                                                    _titleController
                                                                        .text,
                                                                description:
                                                                    _descriptionController
                                                                        .text,
                                                                image: '',
                                                                startDate:
                                                                    startDate,
                                                                endDate:
                                                                    endDate),
                                                            imageFile:
                                                                imageFile!);
                                                  } else {
                                                    BlocProvider.of<
                                                                BannersCubit>(
                                                            context)
                                                        .addBanner(
                                                            banner: BannerModel(
                                                                bannerId: '',
                                                                title:
                                                                    _titleController
                                                                        .text,
                                                                description:
                                                                    _descriptionController
                                                                        .text,
                                                                image: '',
                                                                startDate:
                                                                    startDate,
                                                                endDate:
                                                                    endDate),
                                                            imageFile:
                                                                imageFile!);
                                                  }
                                                }
                                              },
                                              child: Text(widget.banner != null
                                                  ? "Update Banner"
                                                  : "Add Banner")),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            listener:
                                (BuildContext context, BannersState state) {
                              if (state is BannersFailure) {
                              } else if (state is BannersSuccess) {
                                clear();
                                showSnackBar(context,
                                    message: widget.banner != null
                                        ? "Banner updated successfully"
                                        : "Banner added successfully");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 200,
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Add some space after the form
              ],
            ),
    );
  }
}
