import 'dart:io';

import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/functions/load_image.dart';
import 'package:kemet/core/utils/shared_data.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:kemet/core/widgets/custom_snack_bar.dart';
import 'package:kemet/features/settings/presentations/manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../constants.dart';

import '../../manager/edit_photo_cubit/edit_photo_cubit.dart';
import 'edit_profile_form.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();

    File? imageFile;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            children: [
              BlocConsumer<EditPhotoCubit, EditPhotoState>(
                listener: (context, state) {
                  if (state is EditPhotoFailure) {
                    snackBar(state.message, context, Colors.red);
                  }
                  if (state is EditPhotoSuccess) {
                    SharedData.saveUserImage(
                        userImage:
                            state.editProfileModel.user.profilePic!.secureUrl!);
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      final nav = Navigator.of(context);
                      await showDialog(
                          context: context,
                          builder: (context1) {
                            return AlertDialog(
                              title: Text("dialog".tr(context)[0]),
                              contentPadding: const EdgeInsets.all(10),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text("dialog".tr(context)[1]),
                                    onTap: () {
                                      pickImage(ImageSource.camera, imageFile)
                                          .then((value) {
                                        imageFile = value;
                                        nav.pop();
                                      });
                                    },
                                    trailing: Icon(
                                      Icons.camera_alt_outlined,
                                      color: mainColor,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("dialog".tr(context)[2]),
                                    onTap: () {
                                      pickImage(ImageSource.gallery, imageFile)
                                          .then((value) {
                                        imageFile = value;
                                        nav.pop();
                                      });
                                    },
                                    trailing: Icon(
                                      Icons.image,
                                      color: mainColor,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).then((value) => BlocProvider.of<EditPhotoCubit>(
                              context)
                          .editPhoto(imageFile));
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(SharedData.getUserImage()!),
                          radius: size.width * 0.1,
                        ),
                        CircleAvatar(
                          radius: size.width * 0.035,
                          backgroundColor: mainColor,
                          child: (state is EditPhotoLoading)
                              ? const CircularProgressIndicator()
                              : const Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              EditProfileForm(
                formKey: formKey,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              BlocConsumer<EditProfileCubit, EditProfileState>(
                listener: (context, state) {
                  if (state is EditProfileFailure) {
                    snackBar(state.message, context, Colors.red);
                  }
                  if (state is EditProfileSuccess) {
                    SharedData.saveUserName(
                        userName: state.editProfileModel.user.userName);

                    SharedData.saveUserPhone(
                        userPhone: state.editProfileModel.user.phone);
                    SharedData.saveUserAge(
                        age: state.editProfileModel.user.age);
                    snackBar(
                        state.editProfileModel.message, context, Colors.white);
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  if (state is! EditProfileLoading) {
                    return CustomButton(
                      text: 'button'.tr(context)['done'],
                      onPressed: () => submit(context, formKey),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

submit(BuildContext ctx, formKey) {
  if (!formKey.currentState!.validate()) {
    return;
  }
  if (int.parse(editAgeController.text) != SharedData.getUserAge() ||
      editPhoneController.text != SharedData.getUserPhone() ||
      editFNameController.text != SharedData.getUserName()!.split(" ").first ||
      editLNameController.text != SharedData.getUserName()!.split(" ").last) {
    FocusScope.of(ctx).unfocus();
    formKey.currentState!.save();
    BlocProvider.of<EditProfileCubit>(ctx).editProfile(
        editFNameController.text,
        editLNameController.text,
        int.parse(editAgeController.text),
        editPhoneController.text);
  } else {
    snackBar("validateEdit".tr(ctx), ctx, mainColor);
  }
}
