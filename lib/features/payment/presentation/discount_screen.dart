import 'package:alfa_park_handheld_appv2/core/common/gradient_button.dart';
import 'package:alfa_park_handheld_appv2/core/theme/colors.dart';
import 'package:alfa_park_handheld_appv2/features/payment/application/payment_service.dart';
import 'package:alfa_park_handheld_appv2/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscountScreen extends ConsumerStatefulWidget {
  const DiscountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends ConsumerState<DiscountScreen> {
  @override
  Widget build(BuildContext context) {
    final getAllDiscountTypesFuture =
        ref.watch(getAllDiscountTypesFutureProvider);
    return Scaffold(
      body: getAllDiscountTypesFuture.when(
        data: (discounts) {
          return ListView.builder(
            itemCount: discounts.length,
            itemBuilder: (context, index) {
              final discount = discounts[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GradientButton(
                  buttonText: discount.title,
                  onPressed: () {
                    ref.read(paymentServiceProvider).setDiscount(discount);
                    Navigator.pop(context);
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
