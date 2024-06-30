import 'package:kemet/constants.dart';
import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/app_router.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/manager/BNB_cubit/bnbcubit_cubit.dart';
import '../../features/settings/data/repositories/edit_profile_repo_implement.dart';
import '../../features/settings/presentations/manager/sign_out_cubit/sign_out_cubit.dart';
import '../utils/service_locator.dart';
import '../utils/shared_data.dart';
import 'custom_snack_bar.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var index = BlocProvider.of<BNBCubit>(context);
    return Drawer(
      width: width * 0.65,
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.25,
                child: DrawerHeader(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(SharedData.getUserImage()!),
                        radius: width * 0.1,
                      ),
                      SizedBox(
                        height: height * .015,
                      ),
                      Text(
                        SharedData.getUserName()!,
                        style: Style.textThemeW700,
                      ),
                      Text(
                        SharedData.getUserEmail()!,
                        style: Style.textThemeW700,
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    vertical: width * 0.01, horizontal: width * 0.03),
                leading: Icon(
                  Icons.settings_outlined,
                  color: mainColor,
                  size: width * 0.07,
                ),
                title: Text("drawer".tr(context)[0]),
                onTap: () {
                  index.changeIndex(3);
                  Scaffold.of(context).closeDrawer();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    vertical: width * 0.01, horizontal: width * 0.03),
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: mainColor,
                  size: width * 0.07,
                ),
                title: Text("drawer".tr(context)[0]),
                onTap: () {
                  index.changeIndex(2);
                  Scaffold.of(context).closeDrawer();
                },
              ),
              // ListTile(
              //   contentPadding: EdgeInsets.symmetric(
              //       vertical: width * 0.01, horizontal: width * 0.03),
              //   leading: Icon(
              //     Icons.question_answer_rounded,
              //     color: mainColor,
              //     size: width * 0.07,
              //   ),
              //   title: Text("drawer".tr(context)[1]),
              //   onTap: () {
              //     Scaffold.of(context).closeDrawer();
              //   },
              // ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    vertical: width * 0.01, horizontal: width * 0.03),
                leading: Icon(
                  Icons.question_mark_sharp,
                  color: mainColor,
                  size: width * 0.07,
                ),
                title: Text("drawer".tr(context)[2]),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  GoRouter.of(context).push(AppRouter.helps);
                },
              ),
              // ListTile(
              //   contentPadding: EdgeInsets.symmetric(
              //       vertical: width * 0.01, horizontal: width * 0.03),
              //   leading: Icon(
              //     Icons.priority_high_rounded,
              //     color: mainColor,
              //     size: width * 0.07,
              //   ),
              //   title: Text("drawer".tr(context)[3]),
              //   onTap: () {
              //     Scaffold.of(context).closeDrawer();
              //   },
              // ),
              const Spacer(),
              Padding(
                padding:
                    EdgeInsets.only(left: width * .02, bottom: height * .06),
                child: BlocProvider(
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
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.loginPage);
                        snackBar(state.message, context, Colors.white);
                      }
                      if (state is SignOutFailure) {
                        BlocProvider.of<SignOutCubit>(context).signOut();

                        return snackBar(state.message, context, Colors.red);
                      }
                    },
                    builder: (context, state) {
                      if (state is! SignOutLoading) {
                        return SizedBox(
                          width: width * .35,
                          height: height * .05,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Adjust the radius as needed
                              ),
                              backgroundColor:
                                  mainColor, // Change this color to your desired color
                            ),
                            onPressed: () {
                              BlocProvider.of<SignOutCubit>(context).signOut();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.power_settings_new_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  "sign".tr(context)['out'],
                                  style: Style.textThemeW700
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
