import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'routing/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  // Fallback pour Android < 12 (sans Material You)
  static const _seed = Color(0xFFE64A19); // Deep Orange — fitness/énergie

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final light = lightDynamic?.harmonized() ??
            ColorScheme.fromSeed(seedColor: _seed);
        final dark = darkDynamic?.harmonized() ??
            ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark);

        return MaterialApp.router(
          title: 'Chalk',
          themeMode: ThemeMode.system,
          theme: ThemeData(colorScheme: light, useMaterial3: true),
          darkTheme: ThemeData(colorScheme: dark, useMaterial3: true),
          routerConfig: appRouter,
        );
      },
    );
  }
}
