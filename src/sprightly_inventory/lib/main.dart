import 'package:dart_marganam/extensions/enum.dart';
import 'package:flutter/material.dart';
import 'package:sprightly_inventory/core/config/enums.dart';
import 'package:sprightly_inventory/ui/starter/starter_app.dart';

void main(List<String>? args) {
  WidgetsFlutterBinding.ensureInitialized();
  final environment = null != args && args.isNotEmpty
      ? Environment.values.find(args[0]) ?? Environment.prod
      : Environment.prod;
  // print('Environment: ${environment.name}');
  runApp(StarterApp(environment: environment));
}
