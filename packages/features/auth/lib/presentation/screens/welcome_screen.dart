import 'package:auth/presentation/providers/auth_provider.dart';
import 'package:core/extensions/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/widgets/app_text.dart';
import 'package:shared/widgets/app_text_button.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  final VoidCallback? navigateToShowcase;

  const WelcomeScreen({super.key, this.navigateToShowcase});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(context.spacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.waving_hand_outlined, size: 64, color: context.colors.primary),
                SizedBox(height: context.spacing.lg),
                AppText(
                  'Greetings!',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
                SizedBox(height: context.spacing.md),
                if (user != null) ...[
                  AppText(
                    'Name: ${user.displayName ?? "No Name Provided"}',
                    fontSize: 18,
                    color: context.colors.onSurface,
                  ),
                  SizedBox(height: context.spacing.xs),
                  AppText(
                    'Email: ${user.email ?? "No Email Provided"}',
                    fontSize: 16,
                    color: context.colors.onSurface.withValues(alpha: 0.7),
                  ),
                  SizedBox(height: context.spacing.xs),
                  AppText(
                    'Provider: ${authState.providerName}',
                    fontSize: 14,
                    color: context.colors.onSurface.withValues(alpha: 0.5),
                  ),
                ] else ...[
                  AppText(
                    'No user is currently authenticated.',
                    fontSize: 16,
                    color: context.colors.error,
                  ),
                ],
                SizedBox(height: context.spacing.xxl),
                AppTextButton(
                  label: 'Go back to Showcase',
                  onPressed: () => widget.navigateToShowcase?.call(),
                  backgroundColor: context.colors.primary,
                  textColor: context.colors.onPrimary,
                ),
                if (user != null) ...[
                  SizedBox(height: context.spacing.md),
                  AppTextButton(
                    label: 'Sign Out',
                    onPressed: () {
                      ref.read(authProvider.notifier).signOut();
                      widget.navigateToShowcase?.call();
                    },
                    backgroundColor: context.colors.error,
                    textColor: Colors.white,
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
