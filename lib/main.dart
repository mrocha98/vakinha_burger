import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app/app.dart';
import 'app/core/config/env/env.dart';

Future<void> main() async {
  await Env.I.load();
  await GetStorage.init();
  runApp(const App());
}
