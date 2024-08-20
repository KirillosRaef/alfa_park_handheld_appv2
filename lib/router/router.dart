import 'package:alfa_park_handheld_appv2/features/authentication/presentation/login_screen.dart';
import 'package:alfa_park_handheld_appv2/features/configuration/presentation/configuration_screen.dart';
import 'package:alfa_park_handheld_appv2/features/payment/presentation/discount_screen.dart';
import 'package:alfa_park_handheld_appv2/features/payment/presentation/fees_and_payment_options_screen.dart';
import 'package:alfa_park_handheld_appv2/features/services/presentation/all_ticket_types_screen.dart';
import 'package:alfa_park_handheld_appv2/features/services/presentation/create_ticket_screen.dart';
import 'package:alfa_park_handheld_appv2/features/services/presentation/home_screen.dart';
import 'package:alfa_park_handheld_appv2/features/services/presentation/qr_screen.dart';
import 'package:alfa_park_handheld_appv2/features/services/presentation/ticket_info_screen.dart';
import 'package:alfa_park_handheld_appv2/splash_screen.dart';
import 'package:flutter/material.dart';

enum AppRoute {
  splashScreen,
  configurationScreen,
  loginScreen,
  homeScreen,
  allTicketTypesScreen,
  createTicketScreen,
  ticketInfoScreen,
  qrScreen,
  feesAndPaymentOptionsScreen,
  discountScreen,
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case '/config':
        return MaterialPageRoute(
            builder: (context) => const ConfigurationScreen());
      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/all-ticket-types':
        return MaterialPageRoute(
            builder: (context) => const AllTicketTypesScreen());
      case '/create-ticket':
        return MaterialPageRoute(
            builder: (context) => const CreateTicketScreen());
      case '/ticket-info':
        return MaterialPageRoute(
            builder: (context) => const TicketInfoScreen());
      case '/qr':
        return MaterialPageRoute(builder: (context) => const QrScreen());
      case '/fees-and-payment':
        return MaterialPageRoute(builder: (context) => const FeesAndPaymentOptionsScreen());
      case '/discount':
        return MaterialPageRoute(builder: (context) => const DiscountScreen());
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}

extension AppRouteExtension on AppRoute {
  String get name {
    switch (this) {
      case AppRoute.splashScreen:
        return '/splash';
      case AppRoute.configurationScreen:
        return '/config';
      case AppRoute.loginScreen:
        return '/login';
      case AppRoute.homeScreen:
        return '/home';
      case AppRoute.allTicketTypesScreen:
        return '/all-ticket-types';
      case AppRoute.createTicketScreen:
        return '/create-ticket';
      case AppRoute.ticketInfoScreen:
        return '/ticket-info';
      case AppRoute.qrScreen:
        return '/qr';
      case AppRoute.feesAndPaymentOptionsScreen:
        return '/fees-and-payment';
      case AppRoute.discountScreen:
        return '/discount';
      default:
        return '/splash';
    }
  }
}
