import 'package:alfa_park_handheld_appv2/features/payment/data/payment_repository.dart';
import 'package:alfa_park_handheld_appv2/features/payment/domain/discount.dart';
import 'package:alfa_park_handheld_appv2/features/payment/domain/payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final paymentServiceProvider = Provider((ref) {
  final paymentRepository = ref.watch(paymentRepositoryProvider);
  return PaymentService(paymentRepository: paymentRepository, ref: ref);
});

final getAllDiscountTypesFutureProvider =
    FutureProvider.autoDispose((ref) async {
  final paymentService = ref.watch(paymentServiceProvider);
  return await paymentService.fetchDiscounts();
});

class PaymentService {
  final PaymentRepository paymentRepository;
  final ProviderRef ref;
  late Payment payment;
  late Discount discount;

  PaymentService({required this.paymentRepository, required this.ref});

  Future<List<Discount>> fetchDiscounts() async {
    final temp = await paymentRepository.fetchDiscounts();
    List<Discount> discounts =
        temp.map((map) => Discount.fromJson(map)).toList();
    return discounts;
  }

  void setDiscount(Discount disc) {
    discount = Discount(
      type: disc.type,
      title: disc.title,
      value: disc.value,
    );
    payment = Payment(
      ticketId: payment.ticketId,
      ticketTypeId: payment.ticketTypeId,
      ticketCode: payment.ticketCode,
      ticketTitle: payment.ticketTitle,
      ticketNote: payment.ticketNote,
      amount: discount.type == 'Per'
              ? payment.amount * (1 - discount.value)
              : payment.amount - discount.value,
    );
  }

  void setPayment(Payment chosen) {
    payment = Payment(
      ticketId: chosen.ticketId,
      ticketTypeId: chosen.ticketTypeId,
      ticketCode: chosen.ticketCode,
      ticketTitle: chosen.ticketTitle,
      ticketNote: chosen.ticketNote,
      amount: chosen.amount,
    );
  }

  Future<void> payWithCredit() async {
    final prefs = await SharedPreferences.getInstance();
    await paymentRepository.payWithCredit(
      userId: prefs.getInt('user-id')!,
      ticketTypeId: payment.ticketTypeId,
      ticketCode: payment.ticketCode,
      unitId: 'HA',
      amount: payment.amount,
      notes: 'No notes',
    );
  }

  Future<void> refund() async {
    final prefs = await SharedPreferences.getInstance();
    await paymentRepository.refund(
      ticketCode: payment.ticketCode,
      amount: payment.amount,
      pay_type: 1,
      userId: prefs.getInt('user-id')!,
      unitId: 'HA',
      notes: 'No notes',
    );
  }
}
