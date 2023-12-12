import 'package:firstproject/services/auth/auth_provider.dart'
    as customProvider;
import 'package:firstproject/services/auth/auth_provider.dart';
import 'package:firstproject/services/auth/auth_user.dart';
import 'package:firstproject/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final customProvider.AuthProvider provider;
  AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(email: email, password: password);

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}
