import 'package:auth/presentation/providers/login_provider.dart';
import 'package:core/extensions/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/widgets/app_text.dart';
import 'package:shared/widgets/app_text_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final VoidCallback? navigateToRegister;

  const LoginScreen({super.key, this.navigateToRegister});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Center(
                  child: AppText(
                    'Login',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                ),
                SizedBox(height: context.spacing.xxxl),

                // Facebook Button
                AppTextButton(
                  label: 'Login with Facebook',
                  onPressed: loginState.isLoading
                      ? null
                      : () => ref.read(loginProvider.notifier).signInWithFacebook(),
                  backgroundColor: const Color(0xFF1877F2),
                  textColor: Colors.white,
                  margin: EdgeInsets.only(bottom: context.spacing.md),
                ),

                // Apple Button
                AppTextButton(
                  label: 'Login with Apple',
                  onPressed: loginState.isLoading
                      ? null
                      : () => ref.read(loginProvider.notifier).signInWithApple(),
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  margin: EdgeInsets.only(bottom: context.spacing.md),
                ),

                // Google Button
                AppTextButton(
                  label: 'Login with Google',
                  onPressed: loginState.isLoading
                      ? null
                      : () => ref.read(loginProvider.notifier).signInWithGoogle(),
                  backgroundColor: const Color(0xFFDB4437),
                  textColor: Colors.white,
                  margin: EdgeInsets.only(bottom: context.spacing.md),
                ),

                // Register Link
                AppTextButton(
                  label: "Don't have an account? Register",
                  onPressed: loginState.isLoading ? null : () => widget.navigateToRegister?.call(),
                  backgroundColor: Colors.transparent,
                  textColor: context.colors.primary,
                  elevation: 0,
                  margin: EdgeInsets.only(bottom: context.spacing.md),
                ),

                if (loginState.isLoading) ...[
                  SizedBox(height: context.spacing.lg),
                  const Center(child: CircularProgressIndicator()),
                ],

                if (loginState.error != null) ...[
                  SizedBox(height: context.spacing.lg),
                  Center(
                    child: AppText(
                      loginState.error!,
                      color: context.colors.error,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
