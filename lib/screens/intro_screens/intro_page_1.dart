import 'package:flutter/material.dart';
class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EBDD),
      body: Center(
        child: Column(
            children: [
              SizedBox(height: 80,),
              Text("Plant more trees", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), ),
              Container(
                height: 600,
                width: 500,
                child: Image.asset("images/itro1.png"),),
            ],
        ),
      ),
    );
  }
}
