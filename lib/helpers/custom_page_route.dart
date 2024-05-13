import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/auth/auth_root.dart';

class CustomPageRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthRoot.routeName:
        return _pageTransition(
          child: const AuthRoot(),
          settings: settings,
        );
      default:
        return null;
    }
  }

  static PageTransition _pageTransition({
    required Widget child,
    required RouteSettings settings,
  }) {
    return PageTransition(
      child: child,
      type: PageTransitionType.rightToLeftWithFade,
      settings: settings,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );
  }
}
