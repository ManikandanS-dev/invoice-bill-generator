import 'package:firebase_auth/firebase_auth.dart';

final fbAuth = FirebaseAuth.instance;

class AuthRepositories {
  User? get currentUser => fbAuth.currentUser;

  Future<void> login(String email, String password) async {
    try {
      await fbAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }

  Future<void> singUp(String email, String password) async {
    try {
      await fbAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }

  Future<void> sinOut() async {
    try {
      await fbAuth.signOut();
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }
}
