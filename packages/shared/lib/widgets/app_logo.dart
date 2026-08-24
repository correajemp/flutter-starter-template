import 'package:config/gen/assets.gen.dart';
import 'package:core/extensions/theme.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height;
  final double width;
  final double elevation;
  final double radius;

  const AppLogo({
    super.key,
    this.height = 88,
    this.width = 88,
    this.elevation = 18,
    this.radius = 28,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);
    final shadows = elevation > 0 ? context.elevation.shadow(elevation) : null;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: borderRadius, boxShadow: shadows),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Assets.images.appLogo.image(height: height, width: width, fit: BoxFit.cover),
      ),
    );
  }
}
