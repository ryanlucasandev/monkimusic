import 'package:flutter/material.dart';
import 'package:monkimusic/core/images/images.dart';
import 'package:monkimusic/features/player/presentation/pages/home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Image.asset(AppImages.logo, height: 150)),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => HomePage()),
    );
  }
}
