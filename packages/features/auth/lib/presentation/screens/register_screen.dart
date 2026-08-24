import 'package:auth/presentation/providers/register_provider.dart';
import 'package:core/extensions/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/widgets/app_input_field.dart';
import 'package:shared/widgets/app_text.dart';
import 'package:shared/widgets/app_text_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  final VoidCallback? navigateToLogin;

  const RegisterScreen({super.key, this.navigateToLogin});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    ref.read(registerProvider.notifier).signupUser(name: name, email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProvider);

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
                    'Register',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                ),
                SizedBox(height: context.spacing.xxxl),

                // Name Input
                AppInputField(
                  controller: _nameController,
                  hintText: 'Full Name',
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: context.spacing.md),

                // Email Input
                AppInputField(
                  controller: _emailController,
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: context.spacing.md),

                // Password Input
                AppInputField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: context.spacing.xl),

                // Register Button
                AppTextButton(
                  label: 'Register',
                  onPressed: registerState.isLoading ? null : _onRegister,
                  backgroundColor: context.colors.primary,
                  textColor: context.colors.onPrimary,
                ),

                // Already have an account? Login Link
                AppTextButton(
                  label: 'Already have an account? Login',
                  onPressed: registerState.isLoading ? null : () => widget.navigateToLogin?.call(),
                  backgroundColor: Colors.transparent,
                  textColor: context.colors.primary,
                  elevation: 0,
                  margin: EdgeInsets.only(top: context.spacing.md),
                ),

                if (registerState.isLoading) ...[
                  SizedBox(height: context.spacing.lg),
                  const Center(child: CircularProgressIndicator()),
                ],

                if (registerState.error != null) ...[
                  SizedBox(height: context.spacing.lg),
                  Center(
                    child: AppText(
                      registerState.error!,
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
