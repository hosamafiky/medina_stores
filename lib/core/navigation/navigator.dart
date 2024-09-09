import 'package:flutter/cupertino.dart';

import 'constants/imports_constants.dart';
import 'helper/interfaces/helper_imports.dart';
import 'page_router/imports_page_router_builder.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static final BuildContext? _context = _navigatorKey.currentContext;
  static final BuildContext? rootContext = _context;

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  static final PageRouterBuilder _pageRouter = PageRouterBuilder();

  PageRouterBuilder get pageRouter => _pageRouter;

  static Future<T?> to<T extends Object?>(
    Widget page, {
    TransitionType? transition,
    AnimationOption? options,
  }) {
    return _navigatorKey.currentState!.push<T>(_pageRouter.build(
      page,
      transition: transition,
      options: options,
    ));
  }

  static Future<T?> toNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return _navigatorKey.currentState!.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> off<T extends Object?, TO extends Object?>(
    Widget page, {
    TransitionType? transition,
    AnimationOption? options,
  }) {
    return _navigatorKey.currentState!.pushReplacement<T, TO>(_pageRouter.build(
      page,
      transition: transition,
      options: options,
    ));
  }

  static Future<T?> offNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return _navigatorKey.currentState!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static Future<T?> offAll<T extends Object?, TO extends Object?>(
    Widget page, {
    TransitionType? transition,
    AnimationOption? options,
  }) {
    return _navigatorKey.currentState!.pushAndRemoveUntil<T>(
      _pageRouter.build(
        page,
        transition: transition,
        options: options,
      ),
      (route) => false,
    );
  }

  static Future<T?> offAllNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    if (canPop) {
      _navigatorKey.currentState!.pop(result);
    } else {
      _navigatorKey.currentState!.pop(result);
    }
  }

  static bool get canPop => _navigatorKey.currentState!.canPop();
  static Future<bool> get mayPop => _navigatorKey.currentState!.maybePop();
}
