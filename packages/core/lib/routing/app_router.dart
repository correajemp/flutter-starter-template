import 'package:auth/presentation/screens/login_screen.dart';
import 'package:auth/presentation/screens/login_success_screen.dart';
import 'package:auth/presentation/screens/register_screen.dart';
import 'package:auth/presentation/screens/register_success_screen.dart';
import 'package:auth/presentation/screens/welcome_screen.dart';
import 'package:core/routing/app_screens.dart';
import 'package:core/routing/transition_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:showcase/presentation/screens/showcase_screen.dart';
import 'package:splash/presentation/screens/splash_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // final listenable = ValueNotifier<bool>(ref.read(authProvider).isLoggedIn);
  // ref.listen<bool>(authProvider.select((s) => s.isLoggedIn), (_, next) {
  //   listenable.value = next;
  // });
  // ref.onDispose(listenable.dispose);

  return GoRouter(
    initialLocation: '/${AppScreens.splash.route}',
    debugLogDiagnostics: true,
    // refreshListenable: listenable,
    routes: [
      GoRoute(
        path: AppScreens.splash.path,
        name: AppScreens.splash.route,
        pageBuilder: (context, state) => fadeTransitionPage(
          state,
          SplashScreen(
            navigateToLogin: () => context.goNamed(AppScreens.authLogin.route),
            navigateToOnboarding: () {
              // TODO: Navigate to onboarding when implemented
            },
            navigateToDashboard: () {
              // TODO: Navigate to dashboard when implemented
            },
          ),
        ),
      ),
      GoRoute(
        path: AppScreens.showcase.path,
        name: AppScreens.showcase.route,
        pageBuilder: (context, state) => fadeTransitionPage(
          state,
          ShowcaseScreen(
            navigateToLogin: () => context.goNamed(AppScreens.authLogin.route),
            navigateToRegister: () => context.goNamed(AppScreens.authRegister.route),
            navigateToWelcome: () => context.goNamed(AppScreens.authWelcome.route),
            navigateToLoginSuccess: () => context.goNamed(AppScreens.authLoginSuccess.route),
            navigateToRegisterSuccess: () => context.goNamed(AppScreens.authRegisterSuccess.route),
          ),
        ),
      ),
      GoRoute(
        path: AppScreens.authLogin.path,
        name: AppScreens.authLogin.route,
        pageBuilder: (context, state) => fadeTransitionPage(
          state,
          LoginScreen(navigateToRegister: () => context.goNamed(AppScreens.authRegister.route)),
        ),
      ),
      GoRoute(
        path: AppScreens.authRegister.path,
        name: AppScreens.authRegister.route,
        pageBuilder: (context, state) => fadeTransitionPage(
          state,
          RegisterScreen(navigateToLogin: () => context.goNamed(AppScreens.authLogin.route)),
        ),
      ),
      GoRoute(
        path: AppScreens.authWelcome.path,
        name: AppScreens.authWelcome.route,
        pageBuilder: (context, state) => fadeTransitionPage(
          state,
          WelcomeScreen(navigateToShowcase: () => context.goNamed(AppScreens.showcase.route)),
        ),
      ),
      GoRoute(
        path: AppScreens.authLoginSuccess.path,
        name: AppScreens.authLoginSuccess.route,
        pageBuilder: (context, state) => fadeTransitionPage(
          state,
          LoginSuccessScreen(navigateToShowcase: () => context.goNamed(AppScreens.showcase.route)),
        ),
      ),
      GoRoute(
        path: AppScreens.authRegisterSuccess.path,
        name: AppScreens.authRegisterSuccess.route,
        pageBuilder: (context, state) => fadeTransitionPage(
          state,
          RegisterSuccessScreen(
            navigateToShowcase: () => context.goNamed(AppScreens.showcase.route),
          ),
        ),
      ),
    ],
    // redirect: (context, state) {
    //   final authState = ref.read(authProvider);
    //   final isLoggedIn = authState.isLoggedIn;
    //   final location = state.matchedLocation;

    //   if (location == '/${AppScreens.splash.route}') {
    //     return null;
    //   }

    //   final isAuthPath =
    //       location.startsWith('/auth') || location == '/${AppScreens.onboarding.route}';

    //   final isPublicPath = isAuthPath || location == '/${AppScreens.webview.route}';

    //   if (isLoggedIn) {
    //     if (isAuthPath || location == '/${AppScreens.splash.route}') {
    //       return '/${AppScreens.dashboard.route}';
    //     }
    //     return null;
    //   } else {
    //     if (!isPublicPath) {
    //       return '/${AppScreens.authLogin.route}';
    //     }
    //     return null;
    //   }
    // },
  );
});
