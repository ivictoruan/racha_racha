import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomUtils {
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
