import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repositories/auth/auth_repository.dart';
import 'register_controller.dart';
import 'register_page.dart';

class RegisterRouter {
  RegisterRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<RegisterController>(
            create: (context) => RegisterController(
              context.read<AuthRepository>(),
            ),
          )
        ],
        child: const RegisterPage(),
      );
}
