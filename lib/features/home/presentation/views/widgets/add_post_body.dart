import 'dart:io';
import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/functions/load_image.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../manager/add_post_cubit/add_post_cubit.dart';

class AddPostBody extends StatelessWidget {
  const AddPostBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController desController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    File? imageFile;
    Size size = MediaQuery.sizeOf(context);
    return BlocConsumer<AddPostCubit, AddPostState>(
      listener: (ctx, state) {
        if (state is AddPostSuccess) {
          desController.clear();
          BlocProvider.of<AddPostCubit>(ctx).desController.clear();
          BlocProvider.of<AddPostCubit>(ctx).changeIsImage(false);
          snackBar(state.addPostModel.message!, ctx, Colors.white);
          Navigator.pop(ctx);
        }
        if (state is AddPostFailure) {
          snackBar(state.errorMessage, ctx, Colors.red);
        }
      },
      builder: (context, state) {
        bool isImage = BlocProvider.of<AddPostCubit>(context).isImage;
        var isImageFun = BlocProvider.of<AddPostCubit>(context);
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.08),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isImage == false
                        ? ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: size.width * 0.01,
                                horizontal: size.width * 0.02),
                            shape: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.03),
                              borderSide: BorderSide(
                                  width: size.width * 0.002,
                                  color: Colors.grey),
                            ),
                            title:
                                Center(child: Text("addPost".tr(context)[0])),
                            leading: Icon(
                              Icons.camera_alt_outlined,
                              color: mainColor,
                            ),
                            onTap: () async {
                              final nav = Navigator.of(context);
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("dialog".tr(context)[0]),
                                      contentPadding: const EdgeInsets.all(10),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title:
                                                Text("dialog".tr(context)[1]),
                                            onTap: () {
                                              pickImage(ImageSource.camera,
                                                      imageFile)
                                                  .then((value) {
                                                imageFile = value;
                                                isImageFun.changeIsImage(true);
                                                nav.pop();
                                              });
                                            },
                                            trailing: Icon(
                                              Icons.camera_alt_outlined,
                                              color: mainColor,
                                            ),
                                          ),
                                          ListTile(
                                            title:
                                                Text("dialog".tr(context)[2]),
                                            onTap: () {
                                              pickImage(ImageSource.gallery,
                                                      imageFile)
                                                  .then((value) {
                                                imageFile = value;
                                                isImageFun.changeIsImage(true);
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
                                  }).then((value) {});
                            },
                          )
                        : SizedBox(
                            height: size.height * 0.25,
                            width: size.width,
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.fill,
                            )),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Text("addPost".tr(context)[1]),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    CustomTextField(
                      controller: desController,
                      lines: 5,
                      keyboardType: TextInputType.text,
                      validator: (validate) {
                        if (validate!.isEmpty) {
                          return "addPost".tr(context)[2];
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Text("addPost".tr(context)[3]),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                          enable: false,
                          controller: isImageFun.desController,
                          keyboardType: TextInputType.text,
                          validator: (validator) {
                            return null;
                          },
                        )),
                        IconButton(
                          onPressed: () async {
                            isImageFun.changeController();
                          },
                          icon: state is AddLocationLoading
                              ? const CircularProgressIndicator()
                              : Icon(
                                  Icons.location_on,
                                  color: mainColor,
                                  size: MediaQuery.sizeOf(context).width * 0.1,
                                ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    state is! AddPostLoading
                        ? CustomButton(
                            text: "addPost".tr(context)[4],
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate() ||
                                  isImage == false) {
                                isImageFun.addPost({
                                  "desc": desController.text,
                                  "image": imageFile!.path,
                                  "location": isImageFun.desController.text
                                });
                              }
                            })
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
