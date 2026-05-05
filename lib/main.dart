import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:monkimusic/services/service_locator.dart';
import 'package:monkimusic/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeLocator();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
