import 'package:audio_app/Theme/dark_theme.dart';
import 'package:audio_app/views/lounge_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Call Pro',
      theme: darkTheme,
      home: const LoungeView(),
    );
  }
}
