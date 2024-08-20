import 'package:alfa_park_handheld_appv2/core/common/gradient_button.dart';
import 'package:alfa_park_handheld_appv2/core/common/validation_field.dart';
import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:alfa_park_handheld_appv2/features/payment/application/payment_service.dart';
import 'package:alfa_park_handheld_appv2/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeesAndPaymentOptionsScreen extends ConsumerStatefulWidget {
  const FeesAndPaymentOptionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeesAndPaymentOptionsScreenState();
}

class _FeesAndPaymentOptionsScreenState
    extends ConsumerState<FeesAndPaymentOptionsScreen> {
  //final _paymentAmountController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _cardHolderNameController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    //_paymentAmountController.dispose();
    _cardNumberController.dispose();
    _cardHolderNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  // void _showNumberPad() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text("Enter a Number"),
  //         content: TextField(
  //           controller: _paymentAmountController,
  //           keyboardType: TextInputType.number,
  //           decoration: const InputDecoration(
  //             hintText: "Enter a number",
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               setState(() {
  //                 _amount = _paymentAmountController.text;
  //               });
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text("Save"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double amount = ref.read(paymentServiceProvider).payment.amount;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Payment Amount'),
                        Text('$amount EGP'),
                      ],
                    ),
                  ),
                  // const SizedBox(width: 15),
                  // Expanded(
                  //   flex: 5,
                  //   child: GradientButton(
                  //     colors: const [
                  //       AppColors.gradient1,
                  //       AppColors.gradient1,
                  //     ],
                  //     buttonText: "Edit",
                  //     onPressed: _showNumberPad,
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 15),
              ValidationField(
                hintText: 'Card Number',
                controller: _cardNumberController,
              ),
              const SizedBox(height: 15),
              ValidationField(
                hintText: 'Card Holder Name',
                controller: _cardHolderNameController,
                isObscureText: true,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Flexible(
                    child: ValidationField(
                      hintText: 'Expiry Date',
                      controller: _expiryDateController,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Flexible(
                    child: ValidationField(
                      hintText: 'CVV',
                      controller: _cvvController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    child: GradientButton(
                      colors: const [
                        AppColors.gradient1,
                        AppColors.gradient1,
                      ],
                      buttonText: "Pay",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await ref.read(paymentServiceProvider).payWithCredit();
                          Navigator.pushNamed(
                              context, AppRoute.homeScreen.name);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Flexible(
                    child: GradientButton(
                      colors: const [
                        AppColors.gradient1,
                        AppColors.gradient1,
                      ],
                      buttonText: "Discount",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await Navigator.pushNamed(
                              context, AppRoute.discountScreen.name);
                          setState(() {
                            
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
