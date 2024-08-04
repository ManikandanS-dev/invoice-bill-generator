import 'package:invoice/provider/auth_provider/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'singup_provider.g.dart';

@riverpod
class SingUp extends _$SingUp {
  Object? _key;
  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      _key = null;
    });
  }

  Future<void> singUp(String email, String password) async {
    state = const AsyncLoading();
    final key = _key;
    final newstate = await AsyncValue.guard<void>(
      () {
        return ref.read(authRepoProvider).singUp(email, password);
      },
    );
    if (key == _key) {
      state = newstate;
    }
  }

  Future<void> singIn(String email, String password) async {
    state = const AsyncLoading();
    final key = _key;
    final newstate = await AsyncValue.guard(
        () => ref.read(authRepoProvider).login(email, password));
    if (key == _key) {
      state = newstate;
    }
  }
}
