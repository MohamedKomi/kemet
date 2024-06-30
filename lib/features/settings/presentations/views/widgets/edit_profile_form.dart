import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/shared_data.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/style.dart';
import '../../../../../core/widgets/custom_text_field.dart';

final TextEditingController editFNameController = TextEditingController();
final TextEditingController editLNameController = TextEditingController();
final TextEditingController editPhoneController = TextEditingController();
final TextEditingController editAgeController = TextEditingController();

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    editAgeController.text = SharedData.getUserAge().toString();
    editPhoneController.text = SharedData.getUserPhone().toString();
    editFNameController.text =
        SharedData.getUserName().toString().split(" ").first;
    editLNameController.text =
        SharedData.getUserName().toString().split(" ").last;

    final size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //============f_name============
          SizedBox(
            height: size.height * 0.019,
          ),

          Text(
            "f_name".tr(context)['label'],
            style: Style.textThemeW400.copyWith(fontSize: size.width * 0.04),
          ),

          SizedBox(
            height: size.height * 0.007,
          ),

          CustomTextField(
            validator: (validate) {
              if (validate!.isEmpty) {
                return "f_name".tr(context)['valid'];
              }
              return null;
            },
            keyboardType: TextInputType.name,
            hintText: "f_name".tr(context)['hint'],
            controller: editFNameController,
          ),

          SizedBox(
            height: size.height * 0.019,
          ),
          //============l_name===============

          Text(
            "l_name".tr(context)['label'],
            style: Style.textThemeW400.copyWith(fontSize: size.width * 0.04),
          ),

          SizedBox(
            height: size.height * 0.007,
          ),

          CustomTextField(
            validator: (validate) {
              if (validate!.isEmpty) {
                return "l_name".tr(context)['valid'];
              }
              return null;
            },
            keyboardType: TextInputType.name,
            hintText: "l_name".tr(context)['hint'],
            controller: editLNameController,
          ),

          SizedBox(
            height: size.height * 0.019,
          ),
          //==============phone==============

          Text(
            "phone".tr(context)['label'],
            style: Style.textThemeW400.copyWith(fontSize: size.width * 0.04),
          ),

          SizedBox(
            height: size.height * 0.007,
          ),

          CustomTextField(
            validator: (validate) {
              if (validate!.isEmpty) {
                return "phone".tr(context)['valid'];
              }
              return null;
            },
            keyboardType: TextInputType.number,
            hintText: "phone".tr(context)['hint'],
            controller: editPhoneController,
          ),

          SizedBox(
            height: size.height * 0.019,
          ),
          //================age==============

          Text(
            "age".tr(context)['label'],
            style: Style.textThemeW400.copyWith(fontSize: size.width * 0.04),
          ),

          SizedBox(
            height: size.height * 0.007,
          ),

          CustomTextField(
            validator: (validate) {
              if (validate!.isEmpty) {
                return "age".tr(context)['valid'][0];
              } else if (int.parse(editAgeController.text) < 14) {
                return "age".tr(context)['valid'][1];
              }
              return null;
            },
            keyboardType: TextInputType.number,
            hintText: "age".tr(context)['hint'],
            controller: editAgeController,
          ),

          SizedBox(
            height: size.height * 0.019,
          ),
        ],
      ),
    );
  }
}
