import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../pages/home/home_page.dart';

class GlobalContext {
  GlobalContext._();

  static GlobalContext? _instance;

  static GlobalContext get I => _instance ??= GlobalContext._();

  late final GlobalKey<NavigatorState> _navigatorKey;

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;

  final _cache = GetStorage();

  Future<void> loginExpire() async {
    await _cache.remove('accessToken');
    showTopSnackBar(
      _navigatorKey.currentState!.overlay!,
      const CustomSnackBar.error(
        message: 'Login expirado, clique na sacola novamente',
      ),
    );
    _navigatorKey.currentState!.popUntil(
      ModalRoute.withName(HomePage.routeName),
    );
  }
}
