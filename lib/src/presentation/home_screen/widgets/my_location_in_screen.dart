

import 'package:eat_this/src/presentation/home_screen/home_screen_controller.dart';
import 'package:flutter/material.dart';

class MyLocationInScreen extends StatelessWidget {

  const MyLocationInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = HomeScreenController();
    return StreamBuilder<Offset>(
      stream: controller.myLocationInScreen.stream,
      builder: (context, snapShot){
        return Positioned(
          left: snapShot.data?.dx ?? 0,
          top: snapShot.data?.dy ?? 0,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            width: 30, height: 30, ),
        );
      },
    );
  }
}