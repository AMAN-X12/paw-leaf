
import 'package:flutter/material.dart';

import 'app/theme.dart';
import 'app/router.dart';

void main() {
  runApp(const PawLeafApp());
}

class PawLeafApp extends StatelessWidget {
  const PawLeafApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PawLeaf',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}
