import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_template/core/routing/app_screens.dart';
import 'package:flutter_starter_template/features/showcase/presentation/screens/showcase_screen.dart';
import 'package:flutter_starter_template/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

export 'package:flutter_starter_template/core/routing/app_screens.dart';
export 'package:flutter_starter_template/core/routing/transition_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // final listenable = ValueNotifier<bool>(ref.read(authProvider).isLoggedIn);

  // ref.listen<bool>(authProvider.select((s) => s.isLoggedIn), (_, next) {
  //   listenable.value = next;
  // });

  // ref.onDispose(listenable.dispose);

  return GoRouter(
    initialLocation: AppScreens.showcase.path,
    debugLogDiagnostics: true,
    // refreshListenable: listenable,
    routes: [
      GoRoute(
        path: AppScreens.splash.path,
        name: AppScreens.splash.route,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppScreens.showcase.path,
        name: AppScreens.showcase.route,
        builder: (context, state) => const ShowcaseScreen(),
      ),
    ],
    // redirect: (context, state) {
    //   final authState = ref.read(authProvider);
    //   final isLoggedIn = authState.isLoggedIn;
    //   final location = state.matchedLocation;

    //   if (location == AppScreens.splash.path) {
    //     return null;
    //   }

    //   final isAuthPath = location.startsWith('/auth') || location == AppScreens.onboarding.path;

    //   final isPublicPath = isAuthPath;

    //   if (isLoggedIn) {
    //     if (isAuthPath || location == AppScreens.splash.path) {
    //       return AppScreens.dashboard.path;
    //     }
    //     return null;
    //   } else {
    //     if (!isPublicPath) {
    //       return AppScreens.authLogin.path;
    //     }
    //     return null;
    //   }
    // },
  );
});
