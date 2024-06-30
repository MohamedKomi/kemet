import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/features/settings/presentations/manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/utils/style.dart';
import '../../data/repositories/edit_profile_repo_implement.dart';
import '../manager/edit_photo_cubit/edit_photo_cubit.dart';
import 'widgets/edit_profile_body.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                EditProfileCubit(sl<EditProfileRepoImplement>())),
        BlocProvider(
            create: (context) =>
                EditPhotoCubit(sl<EditProfileRepoImplement>())),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xfffafafa),
          elevation: 0,
          centerTitle: true,
          title: Text("acc_screen".tr(context)[1],
              style: Style.textThemeW600.copyWith(fontSize: size.width * 0.04)),
        ),
        body: const EditProfileBody(),
      ),
    );
  }
}
