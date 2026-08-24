import 'package:core/extensions/theme.dart';
import 'package:core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final double? letterSpacing;
  final String? fontFamily;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    this.decorationColor,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        style ??
        TextStyle(
          color: color ?? context.colors.onSurface,
          fontFamily: fontFamily ?? AppTypography.primaryFont,
        );

    final finalStyle = baseStyle.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      fontFamily: fontFamily,
      decoration: decoration,
      decorationColor: decorationColor,
    );

    return Text(
      text ?? '',
      style: finalStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
    );
  }
}
