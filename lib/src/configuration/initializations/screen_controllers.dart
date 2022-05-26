

import 'package:eat_this/src/presentation/home_screen/home_screen_controller.dart';

Future<void> initScreenControllers() async{

  await HomeScreenController().init();
}