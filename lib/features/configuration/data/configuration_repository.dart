import 'package:alfa_park_handheld_appv2/features/configuration/domain/configuration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final configurationRepositoryProvider = Provider<ConfigurationRepository>(
  (ref) => ConfigurationRepository(),
);

class ConfigurationRepository {
  Future<void> saveConfigInSharedPerefs(Configuration config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('url', config.url);
    await prefs.setString('filePath', config.filePath);
  }

  Future<bool> isConfigured() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('url') && prefs.containsKey('filePath');
  }

  Future<void> removeConfigInSharedPerefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('url');
    prefs.remove('filePath');
  }
}
