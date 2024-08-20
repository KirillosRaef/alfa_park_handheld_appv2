import 'dart:io';

import 'package:alfa_park_handheld_appv2/core/common/gradient_button.dart';
import 'package:alfa_park_handheld_appv2/core/common/image_gesture_detector.dart';
import 'package:alfa_park_handheld_appv2/core/common/validation_field.dart';
import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:alfa_park_handheld_appv2/core/utils/image_functions/camera_gallery_bottom_sheet.dart';
import 'package:alfa_park_handheld_appv2/core/utils/image_functions/on_camera_pressed.dart';
import 'package:alfa_park_handheld_appv2/core/utils/image_functions/on_gallery_pressed.dart';
import 'package:alfa_park_handheld_appv2/core/utils/image_functions/set_image.dart';
import 'package:alfa_park_handheld_appv2/features/configuration/application/configuration_service.dart';
import 'package:alfa_park_handheld_appv2/features/configuration/domain/configuration.dart';
import 'package:alfa_park_handheld_appv2/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigurationScreen extends ConsumerStatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConfigurationScreenState();
}

class _ConfigurationScreenState extends ConsumerState<ConfigurationScreen> {
  final _urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _imagePath;
  File? _image;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageGestureDetector(
                image: _image,
                buttonText: _image == null ? 'Select Your Image' : null,
                onTap: () async {
                  _imagePath = await cameraGalleryBottomSheet(
                      context, onCameraPressed, onGalleryPressed);
                  _image = setImage(_imagePath);
                  setState(() {});
                },
              ),
              const SizedBox(height: 15),
              ValidationField(
                hintText: 'URL',
                controller: _urlController,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 20),
              GradientButton(
                colors: const [
                  AppColors.gradient1,
                  AppColors.gradient1,
                ],
                buttonText: "Save",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final config = Configuration(
                      url: _urlController.text.trim(),
                      filePath: _imagePath!,
                    );
                    await ref
                        .read(configurationServiceProvider)
                        .saveConfigInSharedPerefs(config);
                    Navigator.pushNamed(context, AppRoute.loginScreen.name);
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
