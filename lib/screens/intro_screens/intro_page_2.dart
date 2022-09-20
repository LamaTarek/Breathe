import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9ece4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Text("Track your tree", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            Container(
              height: 550,
              width: 400,
              child: Image.asset("images/splash3.png"),),
          ],
        ),
      ),
    );
  }
}