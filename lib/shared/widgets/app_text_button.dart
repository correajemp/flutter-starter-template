import 'package:flutter/material.dart';
import 'package:flutter_starter_template/core/extensions/theme.dart';
import 'package:flutter_starter_template/shared/widgets/app_text.dart';

class AppTextButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Widget? iconWidget;
  final EdgeInsetsGeometry margin;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final double elevation;
  final TextStyle? textStyle;
  final BoxBorder? border;
  final double? radius;

  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconWidget,
    this.margin = const EdgeInsets.only(),
    this.width,
    this.height = 54,
    this.backgroundColor,
    this.textColor,
    this.elevation = 18,
    this.textStyle,
    this.border,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedBgColor = backgroundColor ?? context.colors.primary;
    final resolvedTextColor = textColor ?? context.colors.onPrimary;
    final borderRadius = BorderRadius.circular(radius ?? context.radius.full);
    final shadows = onPressed != null && elevation > 0 ? context.elevation.shadow(elevation) : null;

    return Padding(
      padding: margin,
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(borderRadius: borderRadius, boxShadow: shadows),
          child: Material(
            color: onPressed != null ? resolvedBgColor : context.colors.outlineVariant,
            borderRadius: borderRadius,
            child: InkWell(
              onTap: () {
                onPressed?.call();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              borderRadius: borderRadius,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: context.spacing.lg),
                decoration: BoxDecoration(borderRadius: borderRadius, border: border),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (iconWidget != null) ...[
                      iconWidget!,
                      const SizedBox(width: 8),
                    ] else if (icon != null) ...[
                      Icon(icon, size: 18, color: resolvedTextColor),
                      const SizedBox(width: 8),
                    ],
                    AppText(
                      label,
                      style: textStyle,
                      color: textStyle == null ? resolvedTextColor : null,
                      fontSize: textStyle == null ? 16 : null,
                      fontWeight: textStyle == null ? FontWeight.w600 : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
