import 'package:flutter/material.dart';

class ColorsApp {
  ColorsApp._();

  static ColorsApp? _instance;

  static ColorsApp get I => _instance ??= ColorsApp._();

  Color get primary => const Color(0xff007D21);

  Color get secondary => const Color(0xffF88B0C);
}

extension ColorsAppExtensions on BuildContext {
  ColorsApp get colors => ColorsApp.I;
}
