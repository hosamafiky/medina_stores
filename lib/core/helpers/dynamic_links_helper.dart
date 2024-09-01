import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:medina_stores/core/helpers/dependency_helper.dart';
import 'package:medina_stores/core/navigation/navigator.dart';

import '../../features/product/domain/domain_imports.dart';
import '../../features/product/presentation/presentation_imports.dart';

class DynamicLinksHelper {
  static final _appLinks = AppLinks();
  static handleDynamicLinkWhenAppTerminated() async {
    final linkData = await _appLinks.getInitialLink();

    if (linkData != null && (linkData.scheme == 'https' || linkData.scheme == 'http')) {
      log("We have a link when app is opened: $linkData", name: "DynamicLinksHelper");
      if (linkData.pathSegments.isNotEmpty) {
        final path = linkData.pathSegments.first;
        if (path == 'products') {
          final slug = linkData.pathSegments[1];
          final product = Product(slug: slug, createdAt: DateTime.now());
          AppNavigator.to(ProductPage(
            product,
            cubit: DependencyHelper.instance.serviceLocator<ProductCubit>()..getProductDetails(slug),
          ));
        }
      }
    }
  }

  static void handleDynamicLinkWhenAppIsOpened() async {
    _appLinks.uriLinkStream.listen((linkData) {
      if (linkData.scheme == 'https' || linkData.scheme == 'http') {
        log("We have a link when app is opened: $linkData", name: "DynamicLinksHelper");
        if (linkData.pathSegments.isNotEmpty) {
          final path = linkData.pathSegments.first;
          if (path == 'products') {
            final slug = linkData.pathSegments[1];
            final product = Product(slug: slug, createdAt: DateTime.now());
            AppNavigator.to(ProductPage(
              product,
              cubit: DependencyHelper.instance.serviceLocator<ProductCubit>()..getProductDetails(slug),
            ));
          }
        }
      }
    }).onError((error) {
      log("We have an error catching when app is opened: $error", name: "DynamicLinksHelper");
    });
  }
}
