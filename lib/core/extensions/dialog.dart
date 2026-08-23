import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_template/core/constants/app_constants.dart';
import 'package:flutter_starter_template/shared/components/loading_dialog.dart';

bool _isLoadingDialogShowing = false;
bool _isPlatformDialogShowing = false;

extension DialogX on BuildContext {
  void showLoadingDialog() {
    if (_isLoadingDialogShowing) return;

    _isLoadingDialogShowing = true;
    showDialog<void>(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) _isLoadingDialogShowing = false;
          },
          child: const LoadingDialogContent(),
        );
      },
    ).then((_) {
      _isLoadingDialogShowing = false;
    });
  }

  void dismissLoadingDialog() {
    if (_isLoadingDialogShowing) {
      _isLoadingDialogShowing = false;
      Navigator.of(this, rootNavigator: true).pop();
    }
  }

  Future<Object?> showPlatformDialog({
    String? title,
    String? content,
    String? cancelText,
    String? confirmText = 'OKAY',
    String? neutralText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    VoidCallback? onNeutral,
    bool destructiveConfirm = false,
  }) {
    final isIos = Theme.of(this).platform == TargetPlatform.iOS;

    if (_isPlatformDialogShowing) return Future.value();

    _isPlatformDialogShowing = true;

    if (isIos) {
      return showCupertinoDialog<Object?>(
        context: this,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title ?? AppConstants.appName),
          content: Text(content ?? ''),
          actions: [
            if (neutralText != null || onNeutral != null)
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  onNeutral?.call();
                },
                child: Text(neutralText ?? 'CLOSE'),
              ),
            if (cancelText != null || onCancel != null)
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  onCancel?.call();
                },
                child: Text(cancelText ?? 'CANCEL'),
              ),
            if (confirmText != null || onConfirm != null)
              CupertinoDialogAction(
                isDestructiveAction: destructiveConfirm,
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm?.call();
                },
                child: Text(confirmText ?? 'OKAY'),
              ),
          ],
        ),
      ).then((_) {
        _isPlatformDialogShowing = false;
        return null;
      });
    }

    return showDialog<Object?>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title ?? AppConstants.appName),
        content: Text(content ?? ''),
        actions: [
          if (neutralText != null || onNeutral != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onNeutral?.call();
              },
              child: Text(neutralText ?? 'CLOSE'),
            ),
          if (cancelText != null || onCancel != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              },
              child: Text(cancelText ?? 'CANCEL'),
            ),
          if (confirmText != null || onConfirm != null)
            TextButton(
              style: destructiveConfirm
                  ? TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error)
                  : null,
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              child: Text(confirmText ?? 'OKAY'),
            ),
        ],
      ),
    ).then((_) {
      _isPlatformDialogShowing = false;
      return null;
    });
  }
}
