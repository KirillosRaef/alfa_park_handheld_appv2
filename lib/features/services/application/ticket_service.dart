import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:alfa_park_handheld_appv2/features/payment/domain/payment.dart';
import 'package:alfa_park_handheld_appv2/features/services/data/ticket_repository.dart';
import 'package:alfa_park_handheld_appv2/features/services/domain/ticket.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ticketServiceProvider = Provider((ref) {
  final ticketRepository = ref.watch(ticketRepositoryProvider);
  return TicketService(ticketRepository: ticketRepository, ref: ref);
});

final getAllTicketTypesFutureProvider =
    FutureProvider.autoDispose<List<Ticket>>((ref) async {
  final ticketService = ref.watch(ticketServiceProvider);
  return await ticketService.fetchTickets();
});

class TicketService {
  final TicketRepository ticketRepository;
  final ProviderRef ref;
  late Ticket ticket;
  late String scannedCode;

  TicketService({required this.ticketRepository, required this.ref});

  void setCode(String scannedData) {
    print('Scanned Data FROM SERVICE: $scannedData');
    scannedCode = scannedData;
  }

  Future<List<Ticket>> fetchTickets() async {
    // try {
    //   final temp = await ticketRepository.fetchTickets();
    //   List<Ticket> tickets = temp.map((map) => Ticket.fromJson(map)).toList();
    //   return tickets;
    // } catch (e) {
    //   throw Exception('Error in TicketService');
    // }
    final temp = await ticketRepository.fetchTickets();
    List<Ticket> tickets = temp.map((map) => Ticket.fromJson(map)).toList();
    return tickets;
  }

  void setTicket(Ticket chosen) {
    ticket = Ticket(
      ticketTypeId: chosen.ticketTypeId,
      nameEn: chosen.nameEn,
      nameAr: chosen.nameAr,
      printText: chosen.printText,
    );
  }

  String generateRandom() {
    const symbols = '0123456789qwertyuiopasdfghjklzxcvbnm';
    return List.generate(12, (_) => symbols[Random().nextInt(symbols.length)])
        .join();
  }

  Future<String> convertImageFileToBase64(String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  List<String> cutPlateNumber(String carLicensePlateNumber) {
    try {
      RegExp regex = RegExp(r'(\D+)(\d+)');
      Match? match = regex.firstMatch(carLicensePlateNumber);

      String letters = match?.group(1) ?? '';
      String numbers = match?.group(2) ?? '';

      return [letters, numbers.toString()];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> createTicket({
    required String carLicensePlateNumber,
    required String carLicensePlateImagePath,
    required String driverLicenseImagePath,
    required String carLicenseImagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String code = generateRandom();

    bool createTicket = await ticketRepository.createTicket(
      userId: prefs.getInt('user-id')!,
      ticketTypeId: ticket.ticketTypeId,
      ticketCode: code,
      unitId: 'HD',
      amount: 0.0,
      notes: 'No notes',
      carLicensePlateNumber: cutPlateNumber(carLicensePlateNumber),
      carLicensePlateImagePath: 
          await convertImageFileToBase64(carLicensePlateImagePath),
      driverLicenseImagePath: 
          await convertImageFileToBase64(driverLicenseImagePath),
      carLicenseImagePath: 
       await convertImageFileToBase64(carLicenseImagePath),
    );

    bool entryTicket = await ticketRepository.entryTicket(
      barcode: code,
      unitId: 'HA',
      carLicensePlateImagePath: '',
      driverLicenseImagePath: '',
      carLicenseImagePath: '',
    );
    return createTicket && entryTicket;
  }

  Future<Payment> getTicket(String carLicensePlateNumber) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> tempTicket = await ticketRepository.getTicket(
      ticketCode: scannedCode ?? 'i6kfsthmqlor',
      userId: prefs.getInt('user-id')!,
      unitId: 'HA',
    );
    final payment = Payment.fromJson(tempTicket);
    return payment;
  }
}
