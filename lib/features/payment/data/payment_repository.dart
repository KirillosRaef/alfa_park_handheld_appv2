import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>(
  (ref) => PaymentRepository(),
);

class PaymentRepository {
  Future<void> payWithCredit({
    required int userId,
    required int ticketTypeId,
    required String ticketCode,
    required String unitId,
    required double amount,
    required String notes,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final urlPart = prefs.get('url') as String;
      //const String urlPart = 'https://parkiot.gochauffeur.mobi';

      final url = Uri.parse('$urlPart/api/setPayTicket');

      final response =
      await http.post(url,
          headers: {
            'x-code': prefs.getString('x-code')!,
          },
          body: {
            'user_id': userId.toString(),
            'ticket_type_id': ticketTypeId.toString(),
            'ticket_code': ticketCode,
            'unit_id': unitId,
            'amount': amount.toString(),
            'notes': notes,
          });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData['data']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> refund({
    required String ticketCode,
    required double amount,
    required int pay_type,
    required int userId,
    required String unitId,
    required String notes,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final urlPart = prefs.get('url') as String;
      //const String urlPart = 'https://parkiot.gochauffeur.mobi';

      final url = Uri.parse('$urlPart/api/setRefundTicket');

      final response =
      await http.post(url,
          headers: {
            'x-code': prefs.getString('x-code')!,
          },
          body: {
            'ticket_code': ticketCode,
            'amount': amount.toString(),
            'pay_type': '1',
            'user_id': userId.toString(),
            'unit_id': unitId,
            'notes': notes,
          });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData['data']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> fetchDiscounts() async {
    final prefs = await SharedPreferences.getInstance();
    final urlPart = prefs.get('url') as String;
    //const String urlPart = 'https://parkiot.gochauffeur.mobi';

    final url = Uri.parse('$urlPart/api/getListDiscounts');

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
            'type': map['Type'],
            'title': map['Title'],
            'value': map['Value'],
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
}
