import 'dart:io';

import 'package:alfa_park_handheld_appv2/core/common/gradient_button.dart';
import 'package:alfa_park_handheld_appv2/core/common/image_gesture_detector.dart';
import 'package:alfa_park_handheld_appv2/core/common/validation_field.dart';
import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:alfa_park_handheld_appv2/core/utils/image_functions/camera_gallery_bottom_sheet.dart';
import 'package:alfa_park_handheld_appv2/core/utils/image_functions/on_camera_pressed.dart';
import 'package:alfa_park_handheld_appv2/core/utils/image_functions/on_gallery_pressed.dart';
import 'package:alfa_park_handheld_appv2/core/utils/image_functions/set_image.dart';
import 'package:alfa_park_handheld_appv2/core/utils/show_snack_bar.dart';
import 'package:alfa_park_handheld_appv2/features/services/application/ticket_service.dart';
import 'package:alfa_park_handheld_appv2/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateTicketScreen extends ConsumerStatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTicketScreenState();
}

class _CreateTicketScreenState extends ConsumerState<CreateTicketScreen> {
  final _carLicensePlateNumberController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _carLicensePlateImagePath;
  String? _driverLicenseImagePath;
  String? _carLicenseImagePath;
  File? _carLicensePlateImage;
  File? _driverLicenseImage;
  File? _carLicenseImage;

  @override
  void dispose() {
    _carLicensePlateNumberController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValidationField(
                  hintText: 'License Plate Number',
                  controller: _carLicensePlateNumberController,
                ),
                const SizedBox(height: 15),
                ValidationField(
                  hintText: 'Mobile Number',
                  controller: _mobileNumberController,
                  validate: false,
                ),
                const SizedBox(height: 15),
                ImageGestureDetector(
                  image: _carLicensePlateImage,
                  buttonText: _carLicensePlateImage == null ? 'Select Your Image' : null,
                  onTap: () async {
                    _carLicensePlateImagePath = await cameraGalleryBottomSheet(
                        context, onCameraPressed, onGalleryPressed);
                    _carLicensePlateImage = setImage(_carLicensePlateImagePath);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 15),
                ImageGestureDetector(
                  image: _driverLicenseImage,
                  buttonText: _driverLicenseImage == null
                      ? 'Select Your Image'
                      : null,
                  onTap: () async {
                    _driverLicenseImagePath = await cameraGalleryBottomSheet(
                        context, onCameraPressed, onGalleryPressed);
                    _driverLicenseImage = setImage(_driverLicenseImagePath);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 15),
                ImageGestureDetector(
                  image: _carLicenseImage,
                  buttonText: _carLicenseImage == null
                      ? 'Select Your Image'
                      : null,
                  onTap: () async {
                    _carLicenseImagePath = await cameraGalleryBottomSheet(
                        context, onCameraPressed, onGalleryPressed);
                    _carLicenseImage = setImage(_carLicenseImagePath);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 15),
                GradientButton(
                  colors: const [
                    AppColors.gradient1,
                    AppColors.gradient1,
                  ],
                  buttonText: "Create Ticket",
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _carLicensePlateImage != null &&
                        _driverLicenseImage != null &&
                        _carLicenseImage != null) {
                     await ref.read(ticketServiceProvider).createTicket(
                            carLicensePlateNumber:
                                _carLicensePlateNumberController.text
                                    .trim()
                                    .toLowerCase(),
                            carLicensePlateImagePath:
                                _carLicensePlateImagePath ?? '',
                            driverLicenseImagePath: _driverLicenseImagePath ?? '',
                            carLicenseImagePath: _carLicenseImagePath ?? '',
                          );
                      Navigator.pushNamed(context, AppRoute.homeScreen.name);
                    } else {
                      showSnackBar(context,
                          'Add all images, and the license plate number');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
