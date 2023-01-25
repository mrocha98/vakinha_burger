import 'package:flutter/material.dart';

import 'core/ui/theme/theme_config.dart';
import 'pages/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vakinha Burger',
      theme: ThemeConfig.theme,
      themeMode: ThemeMode.light,
      routes: {
        SplashPage.routeName: (_) => const SplashPage(),
      },
    );
  }
}
