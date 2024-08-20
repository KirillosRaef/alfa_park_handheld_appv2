import 'package:alfa_park_handheld_appv2/core/common/gradient_button.dart';
import 'package:alfa_park_handheld_appv2/core/common/validation_field.dart';
import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:alfa_park_handheld_appv2/features/payment/application/payment_service.dart';
import 'package:alfa_park_handheld_appv2/features/payment/domain/payment.dart';
import 'package:alfa_park_handheld_appv2/features/services/application/ticket_service.dart';
import 'package:alfa_park_handheld_appv2/features/services/presentation/qr_screen.dart';
import 'package:alfa_park_handheld_appv2/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketInfoScreen extends ConsumerStatefulWidget {
  const TicketInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TicketInfoScreenState();
}

class _TicketInfoScreenState extends ConsumerState<TicketInfoScreen> {
  final _carLicensePlateNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool search = false;
  bool showPaymentOptions = false;
  String searchedCarLicense = '';
  late Payment details;

  @override
  void dispose() {
    _carLicensePlateNumberController.dispose();
    super.dispose();
  }

  Future<void> _scanQrCode(BuildContext context) async {
    String? scannedData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QrScreen()),
    );
    if (scannedData != null) {
      print('Scanned Data: $scannedData');
      ref.read(ticketServiceProvider).setCode(scannedData);
      //return ('Scanned Data: $scannedData');
    }
    //return "";
  }

  Widget displayCard() {
    int ticketId = details.ticketId;
    String ticketTitle = details.ticketTitle;
    String ticketNote = details.ticketNote;
    double amount = details.amount;

    return Container(
      width: double.infinity,
      child: Card(
        color: AppColors.borderColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ticket Id: $ticketId',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Title: $ticketTitle',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Note: $ticketNote',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Amount: $amount',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValidationField(
                  controller: _carLicensePlateNumberController,
                  hintText: 'Car License Plate',
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            search = true;
                            details = await ref
                                .read(ticketServiceProvider)
                                .getTicket(_carLicensePlateNumberController.text
                                    .trim()
                                    .toLowerCase());
                            ref
                                .read(paymentServiceProvider)
                                .setPayment(details);
                          } else {
                            search = false;
                          }
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: () async {
                          await Navigator.pushNamed(
                              context, AppRoute.qrScreen.name);
                          search = true;
                          details = await ref
                              .read(ticketServiceProvider)
                              .getTicket('');
                          ref.read(paymentServiceProvider).setPayment(details);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                if (search)
                  Column(
                    children: [
                      const SizedBox(height: 15),
                      displayCard(),
                      const SizedBox(height: 15),
                      GradientButton(
                        buttonText: 'Reprint',
                        onPressed: () {},
                        colors: const [
                          AppColors.gradient1,
                          AppColors.gradient1,
                        ],
                      ),
                      const SizedBox(height: 15),
                      GradientButton(
                        buttonText: 'Pay',
                        onPressed: () {
                          search = false;
                          showPaymentOptions = true;
                          setState(() {});
                        },
                        colors: const [
                          AppColors.gradient1,
                          AppColors.gradient1,
                        ],
                      ),
                      const SizedBox(height: 15),
                      GradientButton(
                        buttonText: 'Refund',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await ref.read(paymentServiceProvider).refund();
                            Navigator.pushNamed(
                                context, AppRoute.homeScreen.name);
                          }
                        },
                        colors: const [
                          AppColors.gradient1,
                          AppColors.gradient1,
                        ],
                      ),
                    ],
                  ),
                if (showPaymentOptions)
                  Column(
                    children: [
                      const SizedBox(height: 15),
                      GradientButton(
                        buttonText: 'Pay With Cash',
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoute.homeScreen.name);
                        },
                        colors: const [
                          AppColors.gradient1,
                          AppColors.gradient1,
                        ],
                      ),
                      const SizedBox(height: 15),
                      GradientButton(
                        buttonText: 'Pay With Credit',
                        onPressed: () {
                          Navigator.pushNamed(context,
                              AppRoute.feesAndPaymentOptionsScreen.name);
                        },
                        colors: const [
                          AppColors.gradient1,
                          AppColors.gradient1,
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
