
import 'package:eat_this/src/configuration/initializations/controllers.dart';
import 'package:eat_this/src/configuration/initializations/permissions.dart';
import 'package:eat_this/src/configuration/initializations/repositories.dart';
import 'package:eat_this/src/configuration/initializations/screen_controllers.dart';
import 'package:eat_this/src/eat_this_app.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await checkLocationPermission();
  repositoriesInjection();
  await initControllers();
  await initScreenControllers();
  runApp(const EatThisApp());
}
