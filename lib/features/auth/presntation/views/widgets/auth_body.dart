import 'package:kemet/core/utils/app_router.dart';
import 'package:kemet/core/utils/shared_data.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:kemet/core/widgets/custom_snack_bar.dart';
import 'package:kemet/features/auth/presntation/maneger/auth_cubit/auth_cubit.dart';
import 'package:kemet/features/auth/presntation/views/widgets/auth_form.dart';
import 'package:kemet/features/auth/presntation/views/widgets/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_localization.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();

    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        final authBloc = BlocProvider.of<AuthCubit>(context);
        bool isLogin = authBloc.isLogin;
        if (state is AuthSuccess) {
          if (isLogin) {
            SharedData.saveToken(token: state.authModel.token!);
            SharedData.saveUserAge(age: state.authModel.user!.age);
            SharedData.saveUserEmail(userEmail: state.authModel.user!.email);
            SharedData.saveUserId(userId: state.authModel.user!.id);
            SharedData.saveUserImage(
                userImage: state.authModel.user!.profilePic.secureUrl!);
            SharedData.saveUserName(userName: state.authModel.user!.userName);
            SharedData.saveUserPhone(userPhone: state.authModel.user!.phone);
          }
          snackBar(state.authModel.message, context, Colors.white);

          isLogin
              ? GoRouter.of(context).pushReplacement(AppRouter.onBoardAppPage)
              : GoRouter.of(context)
                  .push(AppRouter.forgetPassPage, extra: true);
        }
        if (state is AuthFailure) {
          snackBar(state.errMessage, context, Colors.red);
        }
      },
      builder: (context, state) {
        final authBloc = BlocProvider.of<AuthCubit>(context);
        bool isLogin = authBloc.isLogin;
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WelcomeWidget(),
                  AuthForm(isLogin: isLogin, formKey: formKey),
                  SizedBox(
                    height: size.height * 0.019,
                  ),
                  if (isLogin)
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .push(AppRouter.forgetPassPage, extra: false);
                        },
                        child: Text(
                          'forget_password'.tr(context),
                          style: Style.textThemeW400.copyWith(
                            decoration: TextDecoration.underline,
                            fontSize: size.width * 0.035,
                            color: const Color(0xffDAB237),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: size.height * 0.019,
                  ),
                  state is! AuthLoading
                      ? CustomButton(
                          text: isLogin
                              ? "sign".tr(context)['in']
                              : "sign".tr(context)['up'],
                          onPressed: () => submit(isLogin, context, formKey))
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        !isLogin
                            ? "have_acc".tr(context)[0]
                            : 'no_acc'.tr(context)[0],
                        style: Style.textThemeW400.copyWith(
                            fontSize: size.width * 0.025,
                            color: Colors.black.withOpacity(0.7)),
                      ),
                      TextButton(
                        onPressed: () {
                          authBloc.onPressed();
                        },
                        child: Text(
                          !isLogin
                              ? "have_acc".tr(context)[1]
                              : 'no_acc'.tr(context)[1],
                          style: Style.textThemeW600.copyWith(
                              fontSize: size.width * 0.025,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

submit(bool isLogin, BuildContext ctx, formKey) async {
  if (!formKey.currentState!.validate()) {
    return;
  }
  FocusScope.of(ctx).unfocus();
  formKey.currentState!.save();

  isLogin
      ? await BlocProvider.of<AuthCubit>(ctx)
          .login(email: emailController.text, password: passwordController.text)
      : await BlocProvider.of<AuthCubit>(ctx).register(
          email: emailController.text,
          password: passwordController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phone: phoneController.text,
          confirmPassword: confPasswordController.text,
          age: int.parse(ageController.text),
          gender: 'male',
        );
}
