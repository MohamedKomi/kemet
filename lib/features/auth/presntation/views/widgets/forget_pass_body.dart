import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/app_router.dart';
import 'package:kemet/core/utils/assets.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:kemet/core/widgets/custom_snack_bar.dart';
import 'package:kemet/core/widgets/custom_text_field.dart';
import 'package:kemet/features/auth/presntation/maneger/generate_otp_cubit/generate_otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPassBody extends StatelessWidget {
  ForgetPassBody({
    super.key,
    required this.isRegister,
  });

  final bool isRegister;
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
              isRegister
                  ? "registration_screen".tr(context)[0]
                  : 'forget_pass_screen'.tr(context)[0],
              style: Style.textThemeW600.copyWith(fontSize: size.width * 0.05),
            ),
            SizedBox(
              height: size.height * 0.006,
            ),
            Text(
              isRegister
                  ? "registration_screen".tr(context)[1]
                  : 'forget_pass_screen'.tr(context)[1],
              style: Style.textThemeW400.copyWith(fontSize: size.width * 0.03),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            CustomTextField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              helperText: isRegister
                  ? "registration_screen".tr(context)[2]
                  : 'forget_pass_screen'.tr(context)[2],
              validator: (validate) {
                if (validate!.isEmpty) {
                  return "email".tr(context)['valid'][0];
                } else if (!validate.contains('@') ||
                    !validate.contains('.com')) {
                  return "email".tr(context)['valid'][1];
                }
                return null;
              },
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Align(
              alignment: Alignment.center,
              child: BlocConsumer<GenerateOtpCubit, GenerateOtpState>(
                listener: (context, state) {
                  if (state is GenerateOtpSuccess) {
                    GoRouter.of(context).push(AppRouter.otpPage, extra: {
                      'email': controller.text,
                      'isRegister': isRegister,
                      'userId': state.generateOtp.userId
                    });
                    snackBar(state.generateOtp.message, context, Colors.white);
                  }
                  if (state is GenerateOtpFailure) {
                    snackBar(state.message, context, Colors.red);
                  }
                },
                builder: (context, state) {
                  if (state is GenerateOtpLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return CustomButton(
                      text: isRegister
                          ? "registration_screen".tr(context)[3]
                          : 'forget_pass_screen'.tr(context)[3],
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        FocusScope.of(context).unfocus();
                        BlocProvider.of<GenerateOtpCubit>(context)
                            .generateOtp(email: controller.text);
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
