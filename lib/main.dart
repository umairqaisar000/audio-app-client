import 'package:audio_app/Theme/dark_theme.dart';
import 'package:audio_app/socket/init.dart';
import 'package:audio_app/utils/app_data.dart';
import 'package:audio_app/views/home_view.dart';
import 'package:audio_app/views/lounge_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  if (!SocketManager.isSocketInitialized) {
    SocketManager.initSocket();
  }

  runApp(UncontrolledProviderScope(
      container: AppProviderContainer.instance, child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const LoungeView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Call Pro',
      theme: darkTheme,
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          iconSize: 32,
          onTap: _onItemTapped,
          selectedFontSize: 16,
          unselectedFontSize: 14,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mic),
              label: 'Lounges',
            ),
          ],
        ),
      ),
    );
  }
}
