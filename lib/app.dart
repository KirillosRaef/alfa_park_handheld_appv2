import 'package:alfa_park_handheld_appv2/core/theme/theme.dart';
import 'package:alfa_park_handheld_appv2/router/router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking System 2.0',
      initialRoute: AppRoute.splashScreen.name,
      onGenerateRoute: AppRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.light(),
      theme: AppTheme.darkThemeMode,
    );
  }
}
