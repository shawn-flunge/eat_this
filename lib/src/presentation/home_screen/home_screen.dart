

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '이거 먹어'
        ),
      ),
      body: Column(
        children: <Widget>[

          Container(
            width: 100,
            height: 100,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
