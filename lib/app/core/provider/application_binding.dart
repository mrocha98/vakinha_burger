import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/auth/auth_repository.dart';
import '../../repositories/auth/auth_repository_impl.dart';
import '../rest_client/custom_dio.dart';

class ApplicationBinding extends StatelessWidget {
  const ApplicationBinding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CustomDio>(create: (_) => CustomDio()),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            context.read<CustomDio>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
