import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final ticketRepositoryProvider = Provider<TicketRepository>(
  (ref) => TicketRepository(),
);

class TicketRepository {
  Future<List<dynamic>> fetchTickets() async {
    final prefs = await SharedPreferences.getInstance();
    final urlPart = prefs.get('url') as String;
    //const String urlPart = 'https://parkiot.gochauffeur.mobi';

    final url = Uri.parse('$urlPart/api/getAllTicketTypes');

    final response = await http.post(
      url,
      headers: {
        'x-code': prefs.getString('x-code')!,
      },
    );

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        return responseData['data'].map((map) {
          return {
            'ticket_type_id': map['ticket_type_id'],
            'name_en': map['name_en'],
            'name_ar': map['name_ar'],
            'print_text': map['print_text'],
          };
        }).toList();

        //return responseData['data'];
        //return responseData['status'] == true;
      }
      throw Exception('Data is null');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> createTicket({
    required int userId,
    required int ticketTypeId,
    required String ticketCode,
    required String unitId,
    required double amount,
    required String notes,
    required List<String> carLicensePlateNumber,
    required String carLicensePlateImagePath,
    required String driverLicenseImagePath,
    required String carLicenseImagePath,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final urlPart = prefs.get('url') as String;
      //const String urlPart = 'https://parkiot.gochauffeur.mobi';

      final url = Uri.parse('$urlPart/api/setAddTicket');


      final response = await http.post(url,
          headers: {
            'x-code': prefs.getString('x-code')!,
            HttpHeaders.acceptHeader: 'application/json'
          },
          body: {
        "amount": amount.toString(),
        "img1": carLicensePlateImagePath,
        "img2": driverLicenseImagePath,
        "notes": notes,
        "ticket_code": ticketCode,
        "ticket_type_id": ticketTypeId.toString(),
        "unit_id": unitId,
        "user_id": userId.toString(),
        // "plate": ["asd", "123"].toString(),
      });

      print(response.statusCode);
      print(jsonDecode(response.body)['data']);
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> entryTicket({
    required String barcode,
    required String unitId,
    required String carLicensePlateImagePath,
    required String driverLicenseImagePath,
    required String carLicenseImagePath,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final urlPart = prefs.get('url') as String;

      final url = Uri.parse('$urlPart/api/setTicketEntry');

      await http.post(url,
          headers: {
            'x-code': prefs.getString('x-code')!,
          },
          body: jsonEncode({
            'barcode': barcode,
            'unit_id': unitId,
            'img1': carLicensePlateImagePath,
            'img2': driverLicenseImagePath,
            'img3': carLicenseImagePath,
          }));

      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getTicket({
    required String ticketCode,
    required int userId,
    required String unitId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final urlPart = prefs.get('url') as String;
      //const String urlPart = 'https://parkiot.gochauffeur.mobi';

      final url = Uri.parse('$urlPart/api/getTicketFees');

      final response = await http.post(url,
          headers: {
            'x-code': prefs.getString('x-code')!,
          },
          body: {
            'ticket_code': 'i6kfsthmqlor',
            'user_id': '13',
            'unit_id': 'HA',
          });

      print(response.statusCode);
      print(jsonDecode(response.body)['data']);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // return {
        //   'ticket_id': responseData['data']['ticket_id'] ?? 64,
        //   'ticket_type_id': responseData['data']['ticket_type_id'] ?? 2,
        //   'ticket_code': responseData['data']['ticket_code'] ?? 'i6kfsthmqlor',
        //   'ticket_title': responseData['data']['ticket_title'] ?? 'Stud',
        //   'ticket_note': responseData['data']['ticket_note'] ?? 'No notes',
        //   'amount': responseData['data']['amount'] ?? 0,
        // };
        return {
          'ticket_id': responseData['data']['ticket_id'],
          'ticket_type_id': responseData['data']['ticket_type_id'],
          'ticket_code': responseData['data']['ticket_code'],
          'ticket_title': responseData['data']['ticket_title'],
          'ticket_note': responseData['data']['ticket_note'],
          'amount': responseData['data']['amount'] ?? 0,
        };
      }
      throw Exception('Data is null');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
