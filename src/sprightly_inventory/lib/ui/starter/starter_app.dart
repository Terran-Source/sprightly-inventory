import 'package:dart_marganam/widgets.dart' show StatefulWrapper;
import 'package:flutter/material.dart';
import 'package:sprightly_inventory/core/config/enums.dart';
import 'package:sprightly_inventory/core/initiate.dart';
import 'package:sprightly_inventory/ui/starter/starter_page.dart';

class StarterApp extends StatelessWidget {
  final Environment environment;

  const StarterApp({Key? key, required this.environment}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => initiate(environment: environment),
      loading: getMaterialApp, // now optional
      complete: getMaterialApp,
    );
  }
}

MaterialApp get getMaterialApp => MaterialApp(
      title: 'Sprightly Inventory',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StarterPage(title: 'Sprightly Home Page'),
    );
