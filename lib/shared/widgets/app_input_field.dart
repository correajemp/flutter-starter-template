import 'package:flutter/material.dart';
import 'package:flutter_starter_template/core/extensions/theme.dart';
import 'package:flutter_starter_template/core/theme/app_typography.dart';
import 'package:flutter_starter_template/shared/widgets/app_text.dart';

class AppInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool isSuccess;
  final String? errorText;
  final bool obscureText;

  const AppInputField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.keyboardType,
    this.onChanged,
    this.isSuccess = false,
    this.errorText,
    this.obscureText = false,
  });

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;

    Color borderColor = context.colors.outlineVariant;
    if (hasError) {
      borderColor = context.colors.error;
    } else if (widget.isSuccess) {
      borderColor = context.colors.primary;
    } else if (_isFocused) {
      borderColor = context.colors.primary;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: (_isFocused || widget.isSuccess || hasError) ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              if (widget.prefixIcon != null)
                Padding(
                  padding: EdgeInsets.only(left: context.spacing.custom(18)),
                  child: widget.prefixIcon,
                )
              else if (widget.prefixText != null)
                Padding(
                  padding: EdgeInsets.only(left: context.spacing.custom(18)),
                  child: AppText(
                    widget.prefixText,
                    color: context.colors.onSurface,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  onChanged: widget.onChanged,
                  obscureText: widget.obscureText,
                  style: TextStyle(
                    color: context.colors.onSurface,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppTypography.primaryFont,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: context.colors.onSurfaceVariant,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppTypography.primaryFont,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: (widget.prefixText != null || widget.prefixIcon != null)
                          ? context.spacing.xs
                          : context.spacing.custom(18),
                      vertical: context.spacing.custom(15),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              if (widget.suffixIcon != null)
                Padding(
                  padding: EdgeInsets.only(right: context.spacing.custom(18)),
                  child: widget.suffixIcon,
                ),
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 7),
          AppText(
            widget.errorText,
            color: context.colors.error,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ],
      ],
    );
  }
}
