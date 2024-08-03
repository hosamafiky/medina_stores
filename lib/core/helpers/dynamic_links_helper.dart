import 'dart:developer';

import 'package:app_links/app_links.dart';

class DynamicLinksHelper {
  static final _appLinks = AppLinks();
  static handleDynamicLinkWhenAppTerminated() async {
    final linkData = await _appLinks.getInitialLink();

    if (linkData != null && (linkData.scheme == 'https' || linkData.scheme == 'http')) {
      //TODO: Handle the dynamic link when the app is terminated
    }
  }

  static void handleDynamicLinkWhenAppIsOpened() async {
    _appLinks.uriLinkStream.listen((linkData) {
      if (linkData.scheme == 'https' || linkData.scheme == 'http') {
        //TODO: Handle the dynamic link when the app is opened
      }
    }).onError((error) {
      log("We have an error catching when app is opened: $error", name: "DynamicLinksHelper");
    });
  }
}
