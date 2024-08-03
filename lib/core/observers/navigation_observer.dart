import 'dart:developer';

import 'package:flutter/material.dart';

class AppNavigationObserver extends RouteObserver<ModalRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    log('onPush -- Route: ${previousRoute?.settings.name} --> Next Route: ${route.settings.name}', name: 'NavigationObserver');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    log('didReplace -- Route: ${oldRoute?.settings.name} --> Next Route: ${newRoute?.settings.name}', name: 'NavigationObserver');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    log('didPop -- Route: ${previousRoute?.settings.name} -- Next Route: ${route.settings.name}', name: 'NavigationObserver');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    log('didRemove -- Route: ${previousRoute?.settings.name} --> Next Route: ${route.settings.name}', name: 'NavigationObserver');
  }
}
