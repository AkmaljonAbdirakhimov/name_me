import 'package:flutter/material.dart';
import 'package:name_me/presentation/presentation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
          return const QuestionnaireScreen();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
