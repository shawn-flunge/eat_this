import 'package:eat_this/src/configuration/dependencies/repositories_injection.dart';
import 'package:eat_this/src/eat_this_app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  repositoriesInjection();
  runApp(const EatThisApp());
}
