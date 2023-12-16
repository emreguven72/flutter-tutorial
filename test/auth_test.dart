import 'package:firstproject/services/auth/auth_exceptions.dart';
import 'package:firstproject/services/auth/auth_provider.dart';
import 'package:firstproject/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test("Should not be initialized in the beginning", () {
      expect(provider.isInitialized, false);
    });
    test('Cannot log out before initialized', () {
      expect(
        provider.logout(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });
    test("Should be able to initialized", () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test("User should be null after initialization", () {
      expect(provider.currentUser, null);
    });
    test(
      "Should be able to initialized less than 2 seconds",
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );
    test("Create user should call login", () async {
      final badEmailUser = await provider.createUser(
        email: 'foo@bar.com',
        password: 'anyPassword',
      );
      expect(
        badEmailUser,
        throwsA(const TypeMatcher<InvalidCredentialsAuthException>()),
      );
      final badPasswordUser = await provider.createUser(
        email: "any@mail.com",
        password: "foobar",
      );
      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<InvalidCredentialsAuthException>()),
      );
      final user = await provider.createUser(
        email: "correct@mail.com",
        password: "correctPassword",
      );
      expect(user, provider.currentUser);
      expect(user.isEmailVerified, false);
    });
    test("Logged in user should be able to verified", () async {
      await provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });
    test("Should be able to log out and login again", () async {
      await provider.logout();
      await provider.login(
        email: "correct@mail.com",
        password: "correctPassword",
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) {
      throw NotInitializedException();
    }
    await Future.delayed(const Duration(seconds: 1));
    return login(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'foo@bar.com') throw InvalidCredentialsAuthException();
    if (password == 'foobar') throw InvalidCredentialsAuthException();
    const user = AuthUser(
      id: 'anyId',
      email: "any@mail.com",
      isEmailVerified: false,
    );
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logout() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotLoggedInAuthException();
    const newUser = AuthUser(
      id: 'anyId',
      email: 'any@mail.com',
      isEmailVerified: true,
    );
    _user = newUser;
  }
}
