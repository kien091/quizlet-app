import 'package:flutter/material.dart';
import 'package:quizlet/view/login.dart';
import 'package:quizlet/view/onboarding.dart';
import 'package:quizlet/view/register.dart';

MaterialColor customColor = const MaterialColor(0xFF4054AC, {
  50: Color.fromRGBO(64, 84, 172, .1),
  100: Color.fromRGBO(64, 84, 172, .2),
  200: Color.fromRGBO(64, 84, 172, .3),
  300: Color.fromRGBO(64, 84, 172, .4),
  400: Color.fromRGBO(64, 84, 172, .5),
  500: Color.fromRGBO(64, 84, 172, .6),
  600: Color.fromRGBO(64, 84, 172, .7),
  700: Color.fromRGBO(64, 84, 172, .8),
  800: Color.fromRGBO(64, 84, 172, .9),
  900: Color.fromRGBO(64, 84, 172, 1),
});

void main() {
  runApp(
    const Quizlet(),
  );
}

class Quizlet extends StatelessWidget {
  const Quizlet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnBoarding(),
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      routes: {
        '/onboarding': (context) => const OnBoarding(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
      },
    );
  }
}
