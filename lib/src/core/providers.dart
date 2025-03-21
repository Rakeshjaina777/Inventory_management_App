import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthgini/src/core/theme/mode.dart';

import 'network/auth/auth_notifier.dart';
import 'network/auth/auth_repository.dart';

// Global theme mode provider
final themeModeProvider = StateProvider<bool>((ref) => false); // false = Light, true = Dark

// Authentication repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Authentication state provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});
