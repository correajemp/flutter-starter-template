import 'package:core/extensions/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/widgets/app_text.dart';
import 'package:shared/widgets/app_text_button.dart';

class RegisterSuccessScreen extends ConsumerStatefulWidget {
  final VoidCallback? navigateToShowcase;

  const RegisterSuccessScreen({super.key, this.navigateToShowcase});

  @override
  ConsumerState<RegisterSuccessScreen> createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends ConsumerState<RegisterSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(context.spacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(context.spacing.lg),
                  decoration: BoxDecoration(
                    color: context.colors.success.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_add_alt_1_outlined,
                    size: 80,
                    color: context.colors.success,
                  ),
                ),
                SizedBox(height: context.spacing.xl),
                AppText(
                  'Registration Successful!',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
                SizedBox(height: context.spacing.md),
                AppText(
                  'Your account has been successfully created. Thank you for joining us!',
                  fontSize: 16,
                  color: context.colors.onSurface.withValues(alpha: 0.7),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.spacing.xxxl),
                AppTextButton(
                  label: 'Go back to Showcase',
                  onPressed: () => widget.navigateToShowcase?.call(),
                  backgroundColor: context.colors.primary,
                  textColor: context.colors.onPrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
