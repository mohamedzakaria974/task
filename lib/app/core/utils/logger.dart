import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

void initLogger() {
  //to stop prints in production we override the debugPrint method
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((event) {
    if (event.error != null) {
      if (event.level == Level.SEVERE || event.level == Level.SHOUT) {
        debugPrint('Logger $event');
      }
      debugPrint(
          '${event.time} : [${event.level}] - ${event.loggerName} : ${event.message} \n error: ${event.error} \n stacktrace: ${event.stackTrace}');
    } else {
      debugPrint(
          '${event.time} : [${event.level}] - ${event.loggerName} : ${event.message}');
    }
  });
}
