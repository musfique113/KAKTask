import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static void replaceWith(BuildContext context, Widget screen) {
    if (kDebugMode) {
      log('Replacing with: ${screen.runtimeType}');
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static void push(BuildContext context, Widget screen) {
    if (kDebugMode) {
      log('Pushing: ${screen.runtimeType}');
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static void pop(BuildContext context, {Object? result}) {
    if (kDebugMode) {
      log('Popping');
    }
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(result);
    }
  }
}
