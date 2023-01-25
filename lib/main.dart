import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/core/config/env/env.dart';

Future<void> main() async {
  await Env.I.load();
  runApp(const App());
}
