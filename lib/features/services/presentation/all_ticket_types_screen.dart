import 'package:alfa_park_handheld_appv2/core/common/gradient_button.dart';
import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:alfa_park_handheld_appv2/features/services/application/ticket_service.dart';
import 'package:alfa_park_handheld_appv2/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllTicketTypesScreen extends ConsumerStatefulWidget {
  const AllTicketTypesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllTicketTypesScreenState();
}

class _AllTicketTypesScreenState extends ConsumerState<AllTicketTypesScreen> {
  @override
  Widget build(BuildContext context) {
    final getAllTicketTypesFuture = ref.watch(getAllTicketTypesFutureProvider);
    return Scaffold(
      body: getAllTicketTypesFuture.when(
        data: (tickets) {
          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GradientButton(
                  buttonText: ticket.nameEn,
                  onPressed: () {
                    ref.read(ticketServiceProvider).setTicket(ticket);
                    Navigator.pushNamed(
                        context, AppRoute.createTicketScreen.name);
                  },
                  colors: const [
                    AppColors.gradient1,
                    AppColors.gradient1,
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
