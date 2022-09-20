import 'package:breathe/screens/main_page.dart';
import 'package:breathe/screens/side_drawer_screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../forms/login_page.dart';


class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: SizedBox(
                      width: 150, height: 150, child: Image.asset('images/splash.png'),),
                  ),
                )),
            ListTile(
              title: Text("Home"),
              subtitle: Text("Go to home page"),
              trailing: Icon(Icons.home),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              },
            ),
            ListTile(
              title: Text("User profile"),
              subtitle: Text("See your personal info"),
              trailing: Icon(Icons.person),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),

            ListTile(
              title: Text("About us"),
              subtitle: Text("See more about Breathe"),
              trailing: Icon(Icons.info),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                );
              },
            ),
            const SizedBox(height: 60,),
            const Divider(),
            ListTile(
              title: const Text("Logout"),
              subtitle: const Text("Log out from your personal account"),
              trailing: const Icon(Icons.exit_to_app),
              onTap: () async{
                final prefs = await SharedPreferences.getInstance() ;
                prefs.setBool("isLogin", false);
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              child: Image.asset("images/woman_plant.jpeg"),
            ),
            Text("About us", style: TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            RichText(
                text: const TextSpan(text: "'", style: TextStyle(color: Colors.black,fontSize: 17, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: "Breathe", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 17)),
                    TextSpan(text: "'", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)) ,
                    TextSpan(text: ' is a mobile application that aims to encourage people to plant more trees to combat climate change caused by deforestation as an initiative by us to save our dear plant.', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal)),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
