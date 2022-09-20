import 'package:flutter/material.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff73bcb3),
      body: Center(
        child: Container(
          child: Image.asset("images/splash5.png"),

        ),
      ),
    );
  }
}