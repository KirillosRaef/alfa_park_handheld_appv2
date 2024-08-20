import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:flutter/material.dart';

Future<String?> cameraGalleryBottomSheet(
  BuildContext context,
  Future<String?> Function() onCameraPressed,
  Future<String?> Function() onGalleryPressed,
)  async {
  String? image;
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true, // To allow height control
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        color: AppColors.borderColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.camera_alt,
                color: AppColors.whiteColor,
              ),
              onPressed: () async {
                image = await onCameraPressed();
                Navigator.of(context).pop(image);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.image,
                color: AppColors.whiteColor,
              ),
              onPressed: () async {
                image = await onGalleryPressed();
                Navigator.of(context).pop(image);
              },
            ),
          ],
        ),
      );
    },
  );
  return image;
}
