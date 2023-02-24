import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _instance = FirebaseAuth.instance;

  Future<User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response.user;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signupWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response.user;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
