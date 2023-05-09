import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'app_state.dart';

void main() {
  runApp(MegaConvertorApp());
}

class MegaConvertorApp extends StatelessWidget {
  const MegaConvertorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Mega Convertor',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        ),
        home: HomePage(),
      ),
    );
  }
}
