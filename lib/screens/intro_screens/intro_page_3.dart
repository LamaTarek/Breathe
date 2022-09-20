import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 600,
              width: 400,
              child: Image.asset("images/splash4.png"),),
            Text("Gain points", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), )
          ],
        ),
      ),
    );
  }
}