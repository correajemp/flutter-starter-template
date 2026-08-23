import 'package:flutter/material.dart';
import 'package:flutter_starter_template/core/extensions/theme.dart';
import 'package:flutter_starter_template/shared/widgets/app_logo.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final double logoSize;

  const LoadingIndicator({super.key, this.size = 120, this.logoSize = 100});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 10,
              valueColor: AlwaysStoppedAnimation<Color>(context.colors.primary),
              backgroundColor: context.colors.outlineVariant,
            ),
          ),
          AppLogo(width: logoSize, height: logoSize, elevation: 0, radius: 9999),
        ],
      ),
    );
  }
}
