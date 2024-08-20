import 'package:alfa_park_handheld_appv2/features/authentication/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(),
);

class AuthRepository {
  Future<bool> login({required User user}) async {
    final prefs = await SharedPreferences.getInstance();
    final urlPart = prefs.get('url') as String;
    final url = Uri.parse('$urlPart/api2/setUserAuth');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': user.username,
        'pass': user.password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      await prefs.setString('x-code', responseData['data']['x-code']);
      await prefs.setInt('user-id', responseData['data']['user_id']);
      return responseData['status'] == true;
    } else {
      return false;
    }
  }

  Future<void> saveUserInSharedPerefs({required User user}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.username);
    await prefs.setString('password', user.password);
    // await prefs.setString('x-code', user.username);
    // await prefs.setString('user-id', user.password);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('username') && prefs.containsKey('password');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('password');
    prefs.remove('x-code');
    prefs.remove('user-id');
  }

  setUser() {}
}
