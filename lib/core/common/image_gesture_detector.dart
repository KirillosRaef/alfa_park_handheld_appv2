import 'dart:io';

import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ImageGestureDetector extends StatelessWidget {
  final VoidCallback onTap;
  final String? buttonText;
  final File? image;

  const ImageGestureDetector({
    super.key,
    required this.onTap,
    this.image,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return image != null? GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(image!, fit: BoxFit.cover),
        ),
      ),
    ) : GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: AppColors.borderColor,
                height: 150,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.folder_open,
                      size: 40,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      buttonText!,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
