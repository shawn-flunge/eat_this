

import 'package:eat_this/src/domain/controllers/place_controller.dart';
import 'package:eat_this/src/domain/controllers/user_location_controller.dart';

Future<void> initControllers() async{

  await UserLocationController().init();
  await PlaceController().init();
}