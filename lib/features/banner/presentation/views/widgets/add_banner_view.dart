import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/dashboard_cubit/dashboard_cubit.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';

class AddBannerView extends StatefulWidget {
  const AddBannerView({super.key});

  @override
  State<AddBannerView> createState() => _AddBannerViewState();
}

class _AddBannerViewState extends State<AddBannerView> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  late String startDate;
  late String endDate;
  int numberOfDays = 0;

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

  @override
  void initState() {
    startDate = DateFormat('dd/MM/yyyy').format(selectedStartDate);
    endDate = DateFormat('dd/MM/yyyy').format(selectedEndDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text("Add Banner", style: TextStyle(fontSize: 22)),
              Spacer(),
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
        const Spacer(),
        Row(
          children: [
            const SizedBox(
              width: 200,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                Expanded(
                                  child: CustomTextFormField(
                                      label: 'Title',
                                      onChanged: (onChanged) {},
                                      controller: TextEditingController()),
                                ),
                                Spacer(),
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
                                    controller: TextEditingController(),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 300,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightBlueAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text("Choose Banner Image")),
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
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      startDate,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    trailing: const Icon(Icons.date_range),
                                  ),
                                ),
                                const VerticalDivider(),
                                Expanded(
                                  child: ListTile(
                                    title: const Text(
                                      "Number of days",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      numberOfDays.toString(),
                                      style: TextStyle(fontSize: 18),
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
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      endDate,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    trailing: const Icon(Icons.date_range),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text("Add Banner")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 200,
            ),
          ],
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
