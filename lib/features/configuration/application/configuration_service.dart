import 'package:alfa_park_handheld_appv2/features/configuration/data/configuration_repository.dart';
import 'package:alfa_park_handheld_appv2/features/configuration/domain/configuration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final configurationServiceProvider = Provider((ref) {
  final configurationRepository = ref.watch(configurationRepositoryProvider);
  return ConfigurationService(configurationRepository: configurationRepository, ref: ref);
});

class ConfigurationService {
  final ConfigurationRepository configurationRepository;
  final ProviderRef ref;

  ConfigurationService({required this.configurationRepository, required this.ref});

  Future<void> saveConfigInSharedPerefs(Configuration config) async {
    await configurationRepository.saveConfigInSharedPerefs(config);
  }

  Future<bool> isConfigured() async {
    return await configurationRepository.isConfigured();
  }

  Future<void> removeConfigInSharedPerefs() async {
    await configurationRepository.removeConfigInSharedPerefs();
  }
}
