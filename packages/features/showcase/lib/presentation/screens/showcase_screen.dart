import 'package:config/locale/locale_notifier.dart';
import 'package:config/theme/theme_notifier.dart';
import 'package:core/extensions/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/widgets/app_back_button.dart';
import 'package:shared/widgets/app_cached_network_image.dart';
import 'package:shared/widgets/app_card.dart';
import 'package:shared/widgets/app_input_field.dart';
import 'package:shared/widgets/app_logo.dart';
import 'package:shared/widgets/app_shimmer.dart';
import 'package:shared/widgets/app_text.dart';
import 'package:shared/widgets/app_text_button.dart';
import 'package:shared/widgets/loading_indicator.dart';

class ShowcaseScreen extends ConsumerStatefulWidget {
  final VoidCallback? navigateToLogin;
  final VoidCallback? navigateToRegister;
  final VoidCallback? navigateToWelcome;
  final VoidCallback? navigateToLoginSuccess;
  final VoidCallback? navigateToRegisterSuccess;

  const ShowcaseScreen({
    super.key,
    this.navigateToLogin,
    this.navigateToRegister,
    this.navigateToWelcome,
    this.navigateToLoginSuccess,
    this.navigateToRegisterSuccess,
  });

  @override
  ConsumerState<ShowcaseScreen> createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends ConsumerState<ShowcaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundColor,
      appBar: AppBar(
        title: const Text('Widgets Showcase'),
        backgroundColor: context.colors.surfaceColor,
        foregroundColor: context.colors.onSurfaceColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(context.spacing.lg),
          children: [
            _buildSection(
              context,
              title: 'Settings',
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            'Theme Mode',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: context.colors.onSurfaceColor,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextButton(
                                  label: 'Light',
                                  onPressed: () {
                                    ref
                                        .read(themeModeProvider.notifier)
                                        .setThemeMode(ThemeMode.light);
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AppTextButton(
                                  label: 'Dark',
                                  onPressed: () {
                                    ref
                                        .read(themeModeProvider.notifier)
                                        .setThemeMode(ThemeMode.dark);
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AppTextButton(
                                  label: 'System',
                                  onPressed: () {
                                    ref
                                        .read(themeModeProvider.notifier)
                                        .setThemeMode(ThemeMode.system);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.spacing.md),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            'Language',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: context.colors.onSurfaceColor,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextButton(
                                  label: 'English',
                                  onPressed: () {
                                    ref.read(localeProvider.notifier).setLocale(const Locale('en'));
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AppTextButton(
                                  label: 'Filipino',
                                  onPressed: () {
                                    ref
                                        .read(localeProvider.notifier)
                                        .setLocale(const Locale('fil'));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Logos',
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const AppLogo(),
                        const SizedBox(height: 8),
                        Text('AppLogo', style: context.typography.regular),
                      ],
                    ),
                    Column(
                      children: [
                        const AppLogo(),
                        const SizedBox(height: 8),
                        Text('AppLogoDark', style: context.typography.regular),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Navigation',
              children: [
                AppBackButton(
                  title: 'AppBackButton',
                  onTap: () {
                    // Back button context.pop() action is default
                  },
                ),
                SizedBox(height: context.spacing.md),
                AppTextButton(
                  label: 'Go to Login Screen',
                  onPressed: () => widget.navigateToLogin?.call(),
                ),
                SizedBox(height: context.spacing.md),
                AppTextButton(
                  label: 'Go to Register Screen',
                  onPressed: () => widget.navigateToRegister?.call(),
                ),
                SizedBox(height: context.spacing.md),
                AppTextButton(
                  label: 'Go to Auth Welcome Screen',
                  onPressed: () => widget.navigateToWelcome?.call(),
                ),
                SizedBox(height: context.spacing.md),
                AppTextButton(
                  label: 'Go to Login Success Screen',
                  onPressed: () => widget.navigateToLoginSuccess?.call(),
                ),
                SizedBox(height: context.spacing.md),
                AppTextButton(
                  label: 'Go to Register Success Screen',
                  onPressed: () => widget.navigateToRegisterSuccess?.call(),
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Cards',
              children: [
                AppCard(
                  padding: EdgeInsets.all(context.spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Elevated Card (AppCard)',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: context.colors.onSurfaceColor,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This card is utilizing context.elevation and the default surface color.',
                        style: context.typography.regular.copyWith(
                          color: context.colors.onSurfaceColor.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Input Fields',
              children: [
                const AppInputField(
                  hintText: 'Default Input Field',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                SizedBox(height: context.spacing.md),
                const AppInputField(
                  hintText: 'Success Input Field',
                  prefixIcon: Icon(Icons.check_circle_outline),
                  isSuccess: true,
                ),
                SizedBox(height: context.spacing.md),
                const AppInputField(
                  hintText: 'Error Input Field',
                  prefixIcon: Icon(Icons.error_outline),
                  errorText: 'This is an error message',
                ),
                SizedBox(height: context.spacing.md),
                const AppInputField(
                  hintText: 'Obscured Input Field',
                  prefixIcon: Icon(Icons.lock_outline),
                  obscureText: true,
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Buttons',
              children: [
                AppTextButton(label: 'Primary Button', onPressed: () {}),
                SizedBox(height: context.spacing.md),
                AppTextButton(label: 'Button with Icon', icon: Icons.send, onPressed: () {}),
                SizedBox(height: context.spacing.md),
                const AppTextButton(label: 'Disabled Button', onPressed: null),
              ],
            ),
            _buildSection(
              context,
              title: 'Shimmers',
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppShimmer.rectangular(width: double.infinity, height: 40),
                    SizedBox(height: context.spacing.sm),
                    Row(
                      children: [
                        const AppShimmer.circular(size: 60),
                        SizedBox(width: context.spacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppShimmer.rectangular(width: 150, height: 16),
                              SizedBox(height: context.spacing.xs),
                              const AppShimmer.rectangular(width: 100, height: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Cached Images',
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(context.radius.md),
                  child: const AppCachedNetworkImage(
                    imageUrl: 'https://picsum.photos/600/300',
                    height: 150,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Loading Indicators',
              children: const [Center(child: LoadingIndicator())],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.spacing.md),
          child: AppText(
            title,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.colors.primaryColor,
          ),
        ),
        ...children,
        const Divider(height: 32),
      ],
    );
  }
}
