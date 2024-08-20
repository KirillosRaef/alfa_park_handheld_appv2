import 'dart:io';

import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:image_cropper/image_cropper.dart';

Future<String?> cropImage(File imageFile) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: AppColors.borderColor,
        toolbarWidgetColor: AppColors.whiteColor,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
    ],
  );

  if (croppedFile != null) {
    //return File(croppedFile.path);
    return croppedFile.path;
  }
  return null;
}
