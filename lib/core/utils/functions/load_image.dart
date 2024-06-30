
import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File> pickImage(ImageSource source,image) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    image = File(pickedFile.path);
  }
  return image;
}
