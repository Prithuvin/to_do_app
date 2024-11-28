import 'package:flutter/material.dart';
import 'package:to_do_app/controllers/HomeScreenController.dart';

import 'package:to_do_app/views/OnboardingScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Homescreencontroller.initdb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onboardingscreen(),
    );
  }
}
