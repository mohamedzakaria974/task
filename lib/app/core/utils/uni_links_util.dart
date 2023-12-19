import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:uni_links/uni_links.dart';

import '../../routes/app_pages.dart';

typedef DeepLinkHandler = void Function(String? link);

class UniLinksUtil {
  final logger = Logger('SharedPreferences');

  StreamSubscription? _sub;
  late StreamController<String> _linkStreamController;

  Stream<String> get incomingLinkStream => _linkStreamController.stream;

  // Lazily initialized instance
  static UniLinksUtil? _instance;
  DeepLinkHandler? deepLinkHandler;

  factory UniLinksUtil() {
    return _instance ??= UniLinksUtil._internal();
  }

  UniLinksUtil._internal() {
    _linkStreamController = StreamController<String>.broadcast();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    try {
      _sub = linkStream.listen((String? link) {
        if (link?.isNotEmpty ?? false) _linkStreamController.add(link!);
        // Handle the deep link (parse, navigate, etc.)
        deepLinkHandler?.call(link);
      }, onError: (Object err) {
        // Handle errors here
        logger.severe('Error in linkStream.listen: $err');
      });

      // Get the initial deep link on app startup
      String? initialLink = await getInitialLink();
      if (initialLink != null) {
        _linkStreamController.add(initialLink);
        // Handle the initial deep link (parse, navigate, etc.)
        deepLinkHandler?.call(initialLink);
      }
    } on PlatformException {
      // Handle exceptions related to platform services
      logger.severe('Error initializing uni_links');
    }
  }

  void dispose() {
    _sub?.cancel();
    _linkStreamController.close();
  }

}
