import 'package:flutter/material.dart';

import '../../../../../core/utils/app_localization.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../core/widgets/custom_text_field.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confPasswordController = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController ageController = TextEditingController();

class AuthForm extends StatelessWidget {
  const AuthForm({super.key, required this.isLogin, required this.formKey});

  final bool isLogin;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //============f_name============
          SizedBox(
            height: size.height * 0.019,
          ),
          if (!isLogin)
            Text(
              "f_name".tr(context)['label'],
              style: Style.textThemeW400.copyWith(fontSize: size.width * 0.04),
            ),
          if (!isLogin)
            SizedBox(
              height: size.height * 0.007,
            ),
          if (!isLogin)
            CustomTextField(
              validator: (validate) {
                if (validate!.isEmpty) {
                  return "f_name".tr(context)['valid'];
                }
                return null;
              },
              keyboardType: TextInputType.name,
              hintText: "f_name".tr(context)['hint'],
              controller: firstNameController,
            ),
          if (!isLogin)
            SizedBox(
              height: size.height * 0.019,
            ),
          //============l_name===============
          if (!isLogin)
            Text(
              "l_name".tr(context)['label'],
              style: Style.textThemeW400.copyWith(fontSize: size.width * 0.04),
            ),
          if (!isLogin)
            SizedBox(
              height: size.height * 0.007,
            ),
          if (!isLogin)
            CustomTextField(
              validator: (validate) {
                if (validate!.isEmpty) {
                  return "l_name".tr(context)['valid'];
                }
                return null;
              },
              keyboardType: TextInputType.name,
              hintText: "l_name".tr(context)['hint'],
              controller: lastNameController,
            ),
          if (!isLogin)
            SizedBox(
              height: size.height * 0.019,
            ),
          //==============phone==============
          if (!isLogin)
            Text(
              "phone".tr(context)['label'],
              style: Style.textThemeW400.copyWith(fontSize: size.width * 0.04),
            ),
          if (!isLogin)
            SizedBox(
              height: size.height * 0.007,
            ),
          if (!isLogin)
            CustomTextField(
              validator: (validate) {
                if (validate!.isEmpty) {
                  return "phone".tr(context)['valid'];
                }
                return null;
              },
              keyboardType: TextInputType.number,
              hintText: "phone".tr(context)['hint'],
              controller: phoneController,
            ),
          if (!isLogin)
            SizedBox(
              height: size.height * 0.019,
            ),
          //================age==============
          if (!isLogin)
            Text(
              "age".tr(context)['label'],
              style: Style.textThemeW400.copyWith(fontSize: size.width * 0.04),
            ),
          if (!isLogin)
            SizedBox(
              height: size.height * 0.007,
            ),
          if (!isLogin)
            CustomTextField(
              validator: (validate) {
                if (validate!.isEmpty) {
                  return "age".tr(context)['valid'][0];
                } else if (int.parse(ageController.text) < 14) {
                  return "age".tr(context)['valid'][1];
                }
                return null;
              },
              keyboardType: TextInputType.number,
              hintText: "age".tr(context)['hint'],
              controller: ageController,
            ),
          if (!isLogin)
            SizedBox(
              height: size.height * 0.019,
            ),
          //=============email===============

          Text(
            "email".tr(context)['label'],
            style: Style.textThemeW400.copyWith(fontSize: size.width * 0.04),
          ),
          SizedBox(
            height: size.height * 0.007,
          ),
          CustomTextField(
            validator: (validate) {
              if (validate!.isEmpty) {
                return "email".tr(context)['valid'][0];
              } else if (!validate.contains('@') ||
                  !validate.contains('.com')) {
                return "email".tr(context)['valid'][1];
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            hintText: "email".tr(context)['hint'],
            controller: emailController,
          ),
          SizedBox(
            height: size.height * 0.019,
          ),
          //===========password===============
          Text(
            "pass".tr(context)['label'],
            style: Style.textThemeW400.copyWith(fontSize: size.width * 0.04),
          ),
          SizedBox(
            height: size.height * 0.007,
          ),
          CustomTextField(
            validator: (validate) {
              if (validate!.isEmpty) {
                return "pass".tr(context)['valid'][0];
              } else if (validate.length < 6) {
                return "pass".tr(context)['valid'][1];
              }
              return null;
            },
            keyboardType: TextInputType.visiblePassword,
            hintText: "pass".tr(context)['hint'],
            controller: passwordController,
          ),
          SizedBox(
            height: size.height * 0.019,
          ),
          //===========confirm Password========
          if (!isLogin)
            Text(
              "conf_pass".tr(context)['label'],
              style: Style.textThemeW400.copyWith(fontSize: size.width * 0.04),
            ),
          if (!isLogin)
            SizedBox(
              height: size.height * 0.007,
            ),
          if (!isLogin)
            CustomTextField(
              validator: (validate) {
                RegExp regex = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
                if (validate!.isEmpty) {
                  return "conf_pass".tr(context)['valid'][0];
                } else if (confPasswordController.text !=
                    passwordController.text) {
                  return "conf_pass".tr(context)['valid'][1];
                } else if (!regex.hasMatch(validate)) {
                  return "conf_pass".tr(context)['valid'][2];
                }
                return null;
              },
              keyboardType: TextInputType.visiblePassword,
              hintText: "conf_pass".tr(context)['hint'],
              controller: confPasswordController,
            ),
        ],
      ),
    );
  }
}
