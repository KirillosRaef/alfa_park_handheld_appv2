import 'package:alfa_park_handheld_appv2/core/constants/images.dart';
import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:alfa_park_handheld_appv2/features/authentication/application/auth_service.dart';
import 'package:alfa_park_handheld_appv2/features/configuration/application/configuration_service.dart';
import 'package:alfa_park_handheld_appv2/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  void initialConfig() async {
    Future.delayed(const Duration(seconds: 2), () async {
      Navigator.pushNamed(context, AppRoute.discountScreen.name);
      if (!await ref.read(configurationServiceProvider).isConfigured()) {
        Navigator.pushNamed(context, AppRoute.configurationScreen.name);
      } else if (!await ref.read(authServiceProvider).isUserLoggedIn()) {
        Navigator.pushNamed(context, AppRoute.loginScreen.name);
      } else {
        Navigator.pushNamed(context, AppRoute.homeScreen.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initialConfig();
    return Scaffold(
      body: Container(
        color: AppColors.borderColor,
        child: Center(
          child: Image.asset(auraLogo),
        ),
      ),
    );
  }
}
