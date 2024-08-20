import 'package:alfa_park_handheld_appv2/features/authentication/data/auth_repository.dart';
import 'package:alfa_park_handheld_appv2/features/authentication/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthService(authRepository: authRepository, ref: ref);
});

class AuthService {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthService({required this.authRepository, required this.ref});

  Future<bool> login({required User user}) async {
    bool isUser = await authRepository.login(user: user);
    if (isUser) {
      await authRepository.saveUserInSharedPerefs(user: user);
    }
    return isUser;
  }

  Future<bool> isUserLoggedIn() async {
    return await authRepository.isUserLoggedIn();
  }

  Future<void> logout() async {
    return await authRepository.logout();
  }
}
