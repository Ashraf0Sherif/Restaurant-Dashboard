import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widgets/custom_text_form_field.dart';
import '../../logic/additional_ingredient_cubit/additional_ingredient_cubit.dart';
import 'ingredient_type_dropdown_button.dart';

class AddAdditionalIngredientForm extends StatelessWidget {
  const AddAdditionalIngredientForm({
    super.key,
    required GlobalKey<FormState> dialogFormKey,
    required this.dialogAutovalidateMode,
    required TextEditingController titleController,
    required TextEditingController priceController,
    required TextEditingController arabicTitleController,
  })  : _dialogFormKey = dialogFormKey,
        _titleController = titleController,
        _priceController = priceController,
        _arabicTitleController = arabicTitleController;

  final GlobalKey<FormState> _dialogFormKey;
  final AutovalidateMode dialogAutovalidateMode;
  final TextEditingController _titleController;
  final TextEditingController _priceController;
  final TextEditingController _arabicTitleController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _dialogFormKey,
      autovalidateMode: dialogAutovalidateMode,
      child: SizedBox(
        height: 300,
        width: 200,
        child: Column(
          children: [
            CustomTextFormField(label: 'Title', controller: _titleController),
            const SizedBox(height: 15),
            CustomTextFormField(
              label: 'Arabic Title',
              controller: _arabicTitleController,
            ),
            const SizedBox(height: 15),
            BlocBuilder<AdditionalIngredientCubit, AdditionalIngredientState>(
              builder: (context, state) {
                if (state is AdditionalIngredientCurrentTypeChanged &&
                    state.currentType == 'Extra Ingredient') {
                  return Column(
                    children: [
                      CustomTextFormField(
                          numbersOnly: true,
                          label: 'Price',
                          controller: _priceController),
                      const SizedBox(height: 15),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            const IngredientTypeDropDownButton(),
          ],
        ),
      ),
    );
  }
}
