import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/app_router.dart';
import 'package:kemet/core/utils/shared_data.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:kemet/core/widgets/custom_snack_bar.dart';
import 'package:kemet/features/settings/data/repositories/edit_profile_repo_implement.dart';
import 'package:kemet/features/settings/presentations/manager/sign_out_cubit/sign_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/service_locator.dart';
import 'widgets/account_details.dart';
import 'widgets/settings_items.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .06,
              ),
              const AccountDetailsSetting(),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                'acc_screen'.tr(context)[0],
                style:
                    Style.textThemeW600.copyWith(fontSize: size.width * 0.045),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              SettingItem(
                text: 'acc_screen'.tr(context)[1],
                icon1: Icons.account_circle_outlined,
                icon2: Icons.arrow_forward_ios,
                onTap: () {
                  GoRouter.of(context).push(AppRouter.editProfile);
                },
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              SettingItem(
                text: 'acc_screen'.tr(context)[2],
                icon1: Icons.translate,
                icon2: Icons.arrow_forward_ios,
                onTap: () {
                  GoRouter.of(context).push(AppRouter.langPage, extra: false);
                },
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              // SettingItem(
              //   text: 'acc_screen'.tr(context)[3],
              //   icon1: Icons.dark_mode_outlined,
              //   trailing: Switch(
              //     value: false,
              //     onChanged: (value) {},
              //   ),
              // ),
              // SizedBox(
              //   height: size.height * 0.05,
              // ),
              SettingItem(
                text: 'acc_screen'.tr(context)[4],
                icon1: Icons.support_outlined,
                icon2: Icons.arrow_forward_ios,
                onTap: () {
                  GoRouter.of(context).push(AppRouter.support);
                },
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              BlocProvider(
                create: (context) =>
                    SignOutCubit(sl<EditProfileRepoImplement>()),
                child: BlocConsumer<SignOutCubit, SignOutState>(
                  listener: (context, state) {
                    if (state is SignOutSuccess) {
                      SharedData.removeData('token');
                      SharedData.removeData('userId');
                      SharedData.removeData('userName');
                      SharedData.removeData('userImage');
                      SharedData.removeData('userEmail');
                      SharedData.removeData('userAge');
                      SharedData.removeData('userPhone');
                      GoRouter.of(context).pushReplacement(AppRouter.loginPage);
                      snackBar(state.message, context, Colors.white);
                    }
                    if (state is SignOutFailure) {
                      BlocProvider.of<SignOutCubit>(context).signOut();
                      return snackBar(state.message, context, Colors.red);
                    }
                  },
                  builder: (context, state) {
                    if (state is! SignOutLoading) {
                      return CustomButton(
                        text: "sign".tr(context)['out'],
                        onPressed: () {
                          BlocProvider.of<SignOutCubit>(context).signOut();
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
