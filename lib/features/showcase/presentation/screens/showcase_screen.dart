import 'package:flutter/material.dart';
import 'package:flutter_starter_template/core/extensions/theme.dart';
import 'package:flutter_starter_template/shared/widgets/app_back_button.dart';
import 'package:flutter_starter_template/shared/widgets/app_cached_network_image.dart';
import 'package:flutter_starter_template/shared/widgets/app_card.dart';
import 'package:flutter_starter_template/shared/widgets/app_input_field.dart';
import 'package:flutter_starter_template/shared/widgets/app_logo.dart';
import 'package:flutter_starter_template/shared/widgets/app_shimmer.dart';
import 'package:flutter_starter_template/shared/widgets/app_text.dart';
import 'package:flutter_starter_template/shared/widgets/app_text_button.dart';
import 'package:flutter_starter_template/shared/widgets/loading_indicator.dart';

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

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
