// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepoHash() => r'bf1015891c278f22edbe22f3f102bf9adcccf8e5';

/// See also [authRepo].
@ProviderFor(authRepo)
final authRepoProvider = AutoDisposeProvider<AuthRepositories>.internal(
  authRepo,
  name: r'authRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authRepoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepoRef = AutoDisposeProviderRef<AuthRepositories>;
String _$authStateStremHash() => r'd8ff07c2f7490a70b4533b3c57016c2db718b658';

/// See also [authStateStrem].
@ProviderFor(authStateStrem)
final authStateStremProvider = AutoDisposeStreamProvider<User?>.internal(
  authStateStrem,
  name: r'authStateStremProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateStremHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateStremRef = AutoDisposeStreamProviderRef<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
