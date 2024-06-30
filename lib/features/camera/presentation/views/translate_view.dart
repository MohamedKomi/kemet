import 'dart:io';

import 'package:kemet/constants.dart';
import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/style.dart';
import 'package:kemet/core/widgets/custom_snack_bar.dart';
import 'package:kemet/features/camera/data/camera_repo/camera_repo_implement.dart';
import 'package:kemet/features/camera/presentation/manager/camera_cubit/camera_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TranslateView extends StatelessWidget {
  const TranslateView({super.key, required this.imageFile});

  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          CameraCubit(CameraRepoImplement())..fetchPhoto(imageFile),
      child: Scaffold(
        appBar: AppBar(
          title: Text("translate".tr(context)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(size.width * .04),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Image.file(imageFile!)),
                SizedBox(
                  height: size.height * .05,
                ),
                BlocConsumer<CameraCubit, CameraState>(
                    builder: (context, state) {
                  if (state is CameraSuccess) {
                    return Text(
                      state.message,
                      style: Style.textThemeW700.copyWith(
                          color: mainColor, fontSize: size.width * .06),
                    );
                  } else if (state is CameraFailure) {
                    return TextButton(
                      onPressed: () {
                        BlocProvider.of<CameraCubit>(context)
                            .fetchPhoto(imageFile);
                      },
                      child: Text(
                        "try".tr(context),
                        style: Style.textThemeW700.copyWith(color: mainColor),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }, listener: (context, state) {
                  if (state is CameraFailure) {
                    snackBar(state.message, context, Colors.red);
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
