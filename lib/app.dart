import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_template/config/locale/locale_notifier.dart';
import 'package:flutter_starter_template/config/theme/theme_notifier.dart';
import 'package:flutter_starter_template/core/routing/app_router.dart';
import 'package:flutter_starter_template/core/theme/app_theme.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    if (getPlatform(context) == TargetPlatform.android) {
      return GlowingOverscrollIndicator(
        axisDirection: details.direction,
        color: Theme.of(context).colorScheme.secondary,
        child: child,
      );
    }
    return super.buildOverscrollIndicator(context, child, details);
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);
    ref.listen<Locale>(localeProvider, (previous, next) {
      context.setLocale(next);
    });

    return MaterialApp.router(
      title: 'My Title',
      routerConfig: router,
      debugShowCheckedModeBanner:
          // ignore: avoid_redundant_argument_values
          kDebugMode && const String.fromEnvironment('ENV', defaultValue: 'stg') == 'stg',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      scrollBehavior: const AppScrollBehavior(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
