import 'package:invoice/provider/auth_provider/auth_repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_provider.g.dart';

@riverpod
AuthRepositories authRepo(AuthRepoRef ref) {
  return AuthRepositories();
}

@riverpod
Stream<User?> authStateStrem(AuthStateStremRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}
