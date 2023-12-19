import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/initializer.dart';

Future<void> main() async {
  String initialRoute = await Initializer.initialize();
  runApp(App(initialRoute: initialRoute));
}
