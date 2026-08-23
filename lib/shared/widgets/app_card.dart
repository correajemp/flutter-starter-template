import 'package:flutter/material.dart';
import 'package:flutter_starter_template/core/extensions/theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final bool clip;

  const AppCard({
    super.key,
    required this.child,
    this.radius,
    this.padding,
    this.color,
    this.clip = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardRadius = radius ?? context.radius.lg;
    final resolvedColor = color ?? context.colors.surface;

    return Container(
      padding: padding,
      clipBehavior: clip ? Clip.antiAlias : Clip.none,
      decoration: BoxDecoration(
        color: resolvedColor,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: context.elevation.shadow(context.elevation.medium),
      ),
      child: child,
    );
  }
}
