import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:breathe/screens/splash_screens/splash_screen.dart';
import 'package:breathe/screens/main_page.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.asset("images/splash.png"),),
          ],
        ),
      ),
    );
  }

  checkLogin() async{
    Future.delayed(const Duration(seconds: 2), () async{
      final prefs = await SharedPreferences.getInstance();
      bool isLogin = prefs.getBool("isLogin") ?? false;

      if(isLogin){
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else{
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashScreen()));
      }
    }
    );

  }


}
