import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Creates a [CustomTransitionPage] with a fade transition.
CustomTransitionPage<T> fadeTransitionPage<T>(
  GoRouterState state,
  Widget child, {
  Duration duration = const Duration(milliseconds: 250),
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
  );
}

/// Creates a [CustomTransitionPage] with a slide transition.
CustomTransitionPage<T> slideTransitionPage<T>(
  GoRouterState state,
  Widget child, {
  Offset begin = const Offset(1.0, 0.0),
  Duration duration = const Duration(milliseconds: 250),
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          final tween = Tween<Offset>(
            begin: begin,
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
  );
}

/// Creates a [CustomTransitionPage] with a slide-up transition from bottom to top.
CustomTransitionPage<T> slideUpTransitionPage<T>(
  GoRouterState state,
  Widget child, {
  Duration duration = const Duration(milliseconds: 250),
}) {
  return slideTransitionPage<T>(state, child, begin: const Offset(0.0, 1.0), duration: duration);
}

/// Creates a [CustomTransitionPage] with a scale/zoom transition.
CustomTransitionPage<T> scaleTransitionPage<T>(
  GoRouterState state,
  Widget child, {
  Duration duration = const Duration(milliseconds: 250),
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return ScaleTransition(
            scale: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
  );
}

/// Creates a [CustomTransitionPage] with no transition animation.
CustomTransitionPage<T> noTransitionPage<T>(GoRouterState state, Widget child) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return child;
        },
  );
}
