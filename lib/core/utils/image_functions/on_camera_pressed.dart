import 'dart:io';

import 'package:alfa_park_handheld_appv2/core/utils/image_functions/crop_image.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> onCameraPressed() async {
  try {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (xFile != null) {
      return cropImage(File(xFile.path));
    }

    return null;
  } catch (e) {
    return null;
  }
}
