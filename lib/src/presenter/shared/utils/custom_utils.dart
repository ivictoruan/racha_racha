import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomUtils {
  void goTo(String route, BuildContext context) {
    try {
      GoRouter.of(context).push(route);
    } catch (e) {
      log('Não foi possível ir para a rota $route');
    }
  }

  void goToBack(BuildContext context) {
    try {
      GoRouter.of(context).pop();
    } catch (e) {
      log('Não foi possível voltar para página anterior');
    }
  }

  void exitApp() {
    var platform = debugDefaultTargetPlatformOverride;
    if (platform == TargetPlatform.android) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }


  Future goToUrl(String url) async {
    try {
      var newUrl = Uri.tryParse(url);
      if (!await launchUrl(newUrl!)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      log("Não foi possível ur para $url");
    }
  }
}
