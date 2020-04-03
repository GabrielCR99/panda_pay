import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'intro_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      title: const Text('PandaPay'),
      navigateAfterSeconds: IntroScreen(),
      image: Image.asset('images/pandawhite.png'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: Theme.of(context).textTheme.display1,
      loadingText: const Text('Carregando...'),
      photoSize: 100.0,
    );
  }
}
