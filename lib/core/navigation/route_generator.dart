import 'package:flutter/material.dart';

import 'page_router/imports_page_router_builder.dart';

class RouterGenerator {
  RouterGenerator._();

  static final PageRouterBuilder _pageRouter = PageRouterBuilder();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _pageRouter.build(
          Container(),
        );
      default:
        return undefineRoute();
    }
  }
}

Route<dynamic> undefineRoute() {
  return MaterialPageRoute(
    builder: (_) => const Scaffold(
      body: Center(
        child: Text('No route exists here ! '),
      ),
    ),
  );
}
