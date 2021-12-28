import 'package:dart_marganam/extensions/enum.dart';
import 'package:flutter/material.dart';
import 'package:sprightly_inventory/core/config/enums.dart';
import 'package:sprightly_inventory/ui/starter/starter_app.dart';

void mainer(String env) {
  WidgetsFlutterBinding.ensureInitialized();
  final environment = Environment.values.find(env) ?? Environment.prod;
  // print('Environment: ${environment.name}');
  runApp(StarterApp(environment: environment));
}
