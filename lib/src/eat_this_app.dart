
import 'package:eat_this/src/core/constants.dart';
import 'package:eat_this/src/presentation/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class EatThisApp extends StatelessWidget {
  const EatThisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: materialKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const HomeScreen(),
    );
  }
}
