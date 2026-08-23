import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_template/core/constants/app_constants.dart';
import 'package:flutter_starter_template/core/extensions/theme.dart';
import 'package:flutter_starter_template/shared/widgets/app_logo.dart';
import 'package:flutter_starter_template/shared/widgets/app_text.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.systemUiOverlayStyle,
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppLogo(),
              SizedBox(height: 18),
              AppText(
                AppConstants.appName,
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.14,
              ),
              SizedBox(height: 8),
              AppText(
                AppConstants.appName,
                color: Colors.white,
                fontSize: 14.5,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNext() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    // final storage = ref.read(appSettingsStorageProvider);
    // final authState = ref.read(authProvider);
    // if (!storage.isOnboardingCompleted()) {
    //   context.goNamed(AppScreens.onboarding.route);
    // } else if (authState.isLoggedIn) {
    //   context.goNamed(AppScreens.dashboard.route);
    // } else {
    //   context.goNamed(AppScreens.authLogin.route);
    // }
  }
}
