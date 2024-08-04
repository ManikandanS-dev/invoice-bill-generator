import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:invoice/provider/auth_provider/auth_provider.dart';
import 'package:invoice/router/router_name.dart';
import 'package:invoice/screen/home_scr.dart';
import 'package:invoice/screen/login_scr.dart';
import 'package:invoice/screen/splash_scr.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authStateStremProvider);
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      if (authState is AsyncLoading<User?>) {
        return '/splash';
      }

      final authenticate = authState.valueOrNull != null;
      final authenticating = (state.matchedLocation == '/singUP');

      if (authenticate == false) {
        return authenticating ? null : '/singUP';
      }
      final splash = state.matchedLocation == '/splash';
      return (authenticating || splash) ? '/home' : null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: RouterName.splash,
        builder: (context, state) {
          print("------splash----");
          return const SplashScr();
        },
      ),
      GoRoute(
        path: '/singUP',
        name: RouterName.singUp,
        builder: (context, state) {
          return const LoginScr();
        },
      ),
      GoRoute(
        path: '/home',
        name: RouterName.home,
        builder: (context, state) {
          return HomeScr();
        },
      ),
    ],
  );
}
