import 'package:core/extensions/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/widgets/app_text.dart';

class AppBackButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;

  const AppBackButton({super.key, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.chevron_left, color: context.colors.onSurface, size: 36),
        ),
        Expanded(
          child: AppText(
            title,
            color: context.colors.onSurface,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
