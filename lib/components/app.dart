import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taxi/screens/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }

}