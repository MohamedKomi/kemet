import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/app_router.dart';
import 'package:kemet/core/utils/assets.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:kemet/features/auth/presntation/maneger/confirm_email_otp_cubit/confirm_email_otp_cubit.dart';
import 'package:kemet/features/auth/presntation/maneger/confirm_email_otp_cubit/confirm_email_otp_state.dart';
import 'package:kemet/features/auth/presntation/maneger/generate_otp_cubit/generate_otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../../../core/widgets/custom_snack_bar.dart';

class OTPBody extends StatelessWidget {
  OTPBody({
    super.key,
    required this.parameters,
  });

  final Map<String, dynamic> parameters;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
     int? otp=BlocProvider.of<GenerateOtpCubit>(context).otp;
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
              'otp'.tr(context)[0],
              style: Style.textThemeW600.copyWith(fontSize: size.width * 0.05),
            ),
            SizedBox(
              height: size.height * 0.006,
            ),
            Text(
              'otp'.tr(context)[1],
              style: Style.textThemeW400.copyWith(fontSize: size.width * 0.03),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Column(
                  children: [
                    OTPTextField(
                      onChanged: (value) {},
                      onCompleted: (value) {
                        otp = int.parse(value);
                        BlocProvider.of<GenerateOtpCubit>(context).otp=int.parse(value);

                        FocusScope.of(context).unfocus();
                        BlocProvider.of<ConfirmEmailByOTPCubit>(context)
                            .verifyOtp(
                          id: parameters['userId'],
                          otp: otp!,
                          isRegister: parameters['isRegister'],
                        );
                      },
                      width: size.width * 0.9,
                      keyboardType: TextInputType.number,
                      otpFieldStyle: OtpFieldStyle(
                          focusBorderColor: const Color(0xffd8ae2e),
                          enabledBorderColor: Colors.grey),
                      length: 4,
                      fieldWidth: size.width * 0.13,
                      textFieldAlignment: MainAxisAlignment.spaceEvenly,
                      fieldStyle: FieldStyle.box,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    BlocConsumer<ConfirmEmailByOTPCubit,
                        ConfirmEmailByOTPState>(
                      listener: (context, state) {
                        if (state is ConfirmEmailSuccess) {
                          !parameters['isRegister']
                              ? GoRouter.of(context).push(AppRouter.newPassPage,
                                  extra: {
                                      'userId': parameters['userId'],
                                      'otp': otp
                                    })
                              : GoRouter.of(context).push(AppRouter.loginPage);
                          snackBar(state.verifyOtpModel.message!, context,
                              Colors.white);
                        }
                        if (state is ConfirmEmailFailure) {
                          snackBar(state.errorMessage, context, Colors.red);
                        }
                      },
                      builder: (context, state) {
                        if (state is ConfirmEmailLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return CustomButton(
                            text: 'otp'.tr(context)[2],
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<ConfirmEmailByOTPCubit>(context)
                                  .verifyOtp(
                                id: parameters['userId'],
                                otp: otp!,
                                isRegister: parameters['isRegister'],
                              );
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      'otp'.tr(context)[3],
                      style: Style.textThemeW400
                          .copyWith(fontSize: size.width * 0.03),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    BlocBuilder<GenerateOtpCubit, GenerateOtpState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {
                            BlocProvider.of<GenerateOtpCubit>(context)
                                .generateOtp(email: parameters['email']);
                          },
                          child: Text(
                            'otp'.tr(context)[4],
                            style: Style.textThemeW500.copyWith(
                              fontSize: size.width * 0.035,
                              color: const Color(0xffD8AE2E),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
