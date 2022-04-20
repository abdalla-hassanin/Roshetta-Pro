import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff2e94b9),
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo_app.png'),
        ),
      )
    ) ;
  }
}
