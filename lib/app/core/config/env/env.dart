import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  Env._();

  static Env? _instance;

  static Env get I => _instance ??= Env._();

  Future<void> load() async => dotenv.load();

  String? operator [](String key) => dotenv.env[key];
}
