import 'package:core/extensions/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Color? baseColor;
  final Color? highlightColor;

  const AppShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.baseColor,
    this.highlightColor,
  });

  const AppShimmer.rectangular({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.baseColor,
    this.highlightColor,
  }) : shape = BoxShape.rectangle;

  const AppShimmer.circular({super.key, required double size, this.baseColor, this.highlightColor})
    : width = size,
      height = size,
      borderRadius = null,
      shape = BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    final finalBaseColor = baseColor ?? context.colors.surfaceContainer;
    final finalHighlightColor = highlightColor ?? context.colors.surface;

    return Shimmer.fromColors(
      baseColor: finalBaseColor,
      highlightColor: finalHighlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: finalBaseColor,
          shape: shape,
          borderRadius: shape == BoxShape.circle ? null : borderRadius,
        ),
      ),
    );
  }
}
