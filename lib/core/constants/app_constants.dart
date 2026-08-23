import 'package:flutter_starter_template/core/constants/api_urls.dart';
import 'package:flutter_starter_template/core/constants/secret_keys.dart';
import 'package:flutter_starter_template/core/constants/timeouts.dart';

class AppConstants {
  AppConstants();

  static const String appName = 'Flutter Starter Template';
  static const String genericErrorMessage =
      'We\'re unable to process your request. Please try again later.';
  static ApiUrls apiUrls = ApiUrls();
  static Timeouts timeouts = Timeouts();
  static SecretKeys secretKeys = SecretKeys();
}
