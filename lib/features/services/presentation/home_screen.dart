import 'package:alfa_park_handheld_appv2/core/common/gradient_button.dart';
import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:alfa_park_handheld_appv2/features/authentication/application/auth_service.dart';
import 'package:alfa_park_handheld_appv2/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authServiceProvider).logout();
              Navigator.pushNamed(context, AppRoute.loginScreen.name);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientButton(
              colors: const [
                AppColors.gradient1,
                AppColors.gradient1,
              ],
              onPressed: () {
                Navigator.pushNamed(
                    context, AppRoute.allTicketTypesScreen.name);
              },
              buttonText: 'Get Ticket Types',
            ),
            const SizedBox(height: 20),
            GradientButton(
              colors: const [
                AppColors.gradient1,
                AppColors.gradient1,
              ],
              onPressed: () {
                //TODO TO TICKETINFO SCREEN
                Navigator.pushNamed(context, AppRoute.ticketInfoScreen.name);
              },
              buttonText: 'Read Tickets',
            ),
          ],
        ),
      ),
    );
  }
}
