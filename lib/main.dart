import 'package:flutter/material.dart';
import 'topology_screen.dart';
import 'topology_screen_fg.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Graph Test',
      debugShowCheckedModeBanner: false,
      home: TopologyScreen(),
    );
  }
}
