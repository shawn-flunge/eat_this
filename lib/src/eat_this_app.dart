
import 'package:eat_this/src/presentation/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class EatThisApp extends StatelessWidget {
  const EatThisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const HomeScreen(),
    );
  }
}
