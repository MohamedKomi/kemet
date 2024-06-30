import 'dart:io';

import 'package:kemet/core/utils/app_localization.dart';
import 'package:kemet/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/functions/load_image.dart';
import '../../../../../core/utils/style.dart';


class CustomCameraItem extends StatelessWidget {
  const CustomCameraItem({super.key, required this.onTap, required this.text});

  final String onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    File? imageFile;

    final size = MediaQuery.of(context).size;
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
                        pickImage(ImageSource.camera, imageFile).then((value) {
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
                        pickImage(ImageSource.gallery, imageFile).then((value) {
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
            }).then((value) {
          if (imageFile != null) {
            GoRouter.of(context).push(AppRouter.photoView, extra: {
              'image': imageFile,
              'onTap': onTap
            }).then((value) => imageFile = null);
          }
        });
      },
      child: Container(
        width: size.width * .7,
        padding: EdgeInsets.all(size.width * .1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * .07),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  color: mainColor.withOpacity(0.56),
                  offset: Offset(size.width * 0.02, size.height * 0.01))
            ]),
        child: Column(
          children: [
            Icon(
              Icons.photo_camera_outlined,
              size: size.height * .12,
              color: mainColor,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Style.textThemeW700.copyWith(color: mainColor),
            ),
          ],
        ),
      ),
    );
  }
}
