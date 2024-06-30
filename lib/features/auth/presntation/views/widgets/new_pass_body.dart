import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/app_router.dart';
import 'package:kemet/core/utils/assets.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:kemet/core/widgets/custom_snack_bar.dart';
import 'package:kemet/core/widgets/custom_text_field.dart';
import 'package:kemet/features/auth/presntation/maneger/reset_password_cubit/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewPassBody extends StatelessWidget {
  NewPassBody({
    super.key,
    required this.parameters,
  });

  final Map<String, dynamic> parameters;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(
          size.width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsService.logo,
              width: size.width * 0.3,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              'new_pass_screen'.tr(context)[0],
              style: Style.textThemeW600.copyWith(fontSize: size.width * 0.05),
            ),
            SizedBox(
              height: size.height * 0.006,
            ),
            Text(
              'new_pass_screen'.tr(context)[1],
              style: Style.textThemeW400.copyWith(fontSize: size.width * 0.03),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            CustomTextField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              helperText: 'new_pass_screen'.tr(context)[2],
              validator: (validate) {
                RegExp regex = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
                if (validate!.isEmpty) {
                  return "conf_pass".tr(context)['valid'][0];
                } else if (!regex.hasMatch(validate)) {
                  return "conf_pass".tr(context)['valid'][2];
                }
                return null;
              },
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Align(
              alignment: Alignment.center,
              child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                listener: (context, state) {
                  if (state is ResetPasswordSuccess) {
                    GoRouter.of(context).push(AppRouter.loginPage);
                    snackBar(state.message, context, Colors.white);
                  }
                  if (state is ResetPasswordFailure) {
                    snackBar(state.message, context, Colors.red);
                  }
                },
                builder: (context, state) {
                  if (state is ResetPasswordLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return CustomButton(
                      text: 'new_pass_screen'.tr(context)[0],
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        FocusScope.of(context).unfocus();
                        BlocProvider.of<ResetPasswordCubit>(context)
                            .resetPassword(
                                password: controller.text, data: parameters);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
